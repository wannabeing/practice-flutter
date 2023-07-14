import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// 🚀 [LISTEN] 비디오 컬렉션 생성
export const listenAddVideo = functions
  .region("asia-northeast3")
  .firestore.document("videos/{vid}")
  .onCreate(async (snapshot, context) => {
    // ✅ 새로 생성된 비디오 모델 및 비디오ID
    const video = snapshot.data();
    const videoID = snapshot.id;

    // ✅ 썸네일 추출 및 임시저장
    const spawn = require("child-process-promise").spawn;
    await spawn("ffmpeg", [
      "-i",
      video.videoURL, // 비디오 모델의 링크
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${videoID}.jpg`, // 임시 저장 경로
    ]);

    // ✅ 썸네일 FireStorage에 저장
    // thumbnails/:uid/:video.title
    const storage = admin.storage();

    const [thumbFile, _] = await storage
      .bucket()
      .upload(`/tmp/${videoID}.jpg`, {
        destination: `thumbnails/${video.uid}/${video.title}.jpg`,
      });

    // ✅ 새로 생성된 비디오 모델에 썸네일 URL/비디오ID 저장
    await thumbFile.makePublic();
    await snapshot.ref.update({
      vid: videoID,
      thumbURL: thumbFile.publicUrl(),
    });

    // ✅ 업로드한 유저모델에 새로운 컬렉션 생성 및 저장 (비디오 모델 관련)
    // users/:uid/myVideos/:vid/{ vid, thumbURL, createdAt }
    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.uid)
      .collection("myVideos")
      .doc(videoID)
      .set({
        vid: videoID,
        title: video.title,
        thumbURL: thumbFile.publicUrl(),
        createdAt: video.createdAt,
      });
    // ✅ 업로드한 비디오모델에 새로운 컬렉션 생성 및 저장 (유저모델 관련)
    // videos/:vid/creator/:uid/ {uid, displayName, avatarURL}
    const user = (await db.collection("users").doc(video.uid).get()).data();
    await db
      .collection("videos")
      .doc(videoID)
      .collection("creator")
      .doc(video.uid)
      .set({
        uid: video.uid,
        displayName: user!.displayName,
        avatarURL: user!.avatarURL,
      });
  });

// 🚀 [LISTEN] 좋아요 컬렉션 생성
export const listenAddLike = functions
  .region("asia-northeast3")
  .firestore.document("likes/{likeID}")
  .onCreate(async (snapshot, context) => {
    const like = snapshot.data();

    // ✅ 유저모델에 새로운 컬렉션 생성 및 저장 (좋아요 모델 관련)
    // users/:uid/myLikes/:vid/{ vid, thumbURL, createdAt }
    const db = admin.firestore();

    // 좋아요 누른 비디오 모델
    const likeVideo = (
      await db.collection("videos").doc(like.vid).get()
    ).data();

    // ✅ 좋아요 누른 비디오모델이 있다면
    if (likeVideo) {
      // ✅ 좋아요 1 증가
      await db
        .collection("videos")
        .doc(like.vid)
        .update({
          likes: admin.firestore.FieldValue.increment(1),
        });

      // ✅ 유저모델에 해당 비디오모델 저장
      await db
        .collection("users")
        .doc(like.uid)
        .collection("myLikesVideos")
        .doc(like.vid)
        .set({
          vid: like.vid,
          title: likeVideo.title,
          thumbURL: likeVideo.thumbURL,
          createdAt: likeVideo.createdAt,
        });
    }
  });

// 🚀 [LISTEN] 좋아요 컬렉션 삭제
export const listenDelLike = functions
  .region("asia-northeast3")
  .firestore.document("likes/{likeID}")
  .onDelete(async (snapshot, context) => {
    const like = snapshot.data();
    const db = admin.firestore();

    // 좋아요 중복으로 누른 비디오 모델
    const likeVideo = (
      await db.collection("videos").doc(like.vid).get()
    ).data();

    // ✅ 좋아요 중복으로 누른 비디오모델이 있다면
    if (likeVideo) {
      // ✅ 좋아요 1 감소
      await db
        .collection("videos")
        .doc(like.vid)
        .update({
          likes: admin.firestore.FieldValue.increment(-1),
        });

      // ✅ 유저모델에 해당 비디오모델 삭제
      await db
        .collection("users")
        .doc(like.uid)
        .collection("myLikesVideos")
        .doc(like.vid)
        .delete();
    }
  });

// 🚀 [LISTEN] 채팅방 컬렉션 생성
export const listenAddChatRoom = functions
  .region("asia-northeast3")
  .firestore.document("chatRooms/{chatRoomID}")
  .onCreate(async (snapshot, context) => {
    const chatRoom = snapshot.data(); // 생성된 채팅방 컬렉션 데이터
    const db = admin.firestore();

    // ✅ 대화시작유저 / 상대유저 가져오기
    const firstUser = (
      await db.collection("users").doc(chatRoom.firstUID).get()
    ).data();
    const oppUser = (
      await db.collection("users").doc(chatRoom.oppUID).get()
    ).data();

    // ✅ 두 유저 컬렉션에 나의채팅방 컬렉션 생성
    if (firstUser && oppUser) {
      await db
        .collection("users")
        .doc(firstUser.uid)
        .collection("myChats")
        .doc(context.params.chatRoomID)
        .set({
          chatRoomID: context.params.chatRoomID,
          oppUID: oppUser.uid,
          oppDisplayname: oppUser.displayName,
          oppAvatarURL: oppUser.avatarURL,
        });
      await db
        .collection("users")
        .doc(oppUser.uid)
        .collection("myChats")
        .doc(context.params.chatRoomID)
        .set({
          chatRoomID: context.params.chatRoomID,
          oppUID: firstUser.uid,
          oppDisplayname: firstUser.displayName,
          oppAvatarURL: firstUser.avatarURL,
        });
    }
  });

// 🚀 [LISTEN] 채팅 텍스트 컬렉션 생성
export const listenAddChat = functions
  .region("asia-northeast3")
  .firestore.document("chatRooms/{chatRoomID}/texts/{textID}")
  .onCreate(async (snapshot, context) => {
    const newChat = snapshot.data(); // 새로 생성된 채팅 텍스트 컬렉션 데이터
    const chatRoomID = context.params.chatRoomID; // 채팅방 id
    const [firstUID, oppUID] = chatRoomID.split("000"); // 두 유저 id
    const db = admin.firestore(); // db

    // ✅ 채팅방 컬렉션 업데이트 (마지막 텍스트)
    db.collection("chatRooms").doc(chatRoomID).update({
      lastText: newChat.text,
      lastTime: newChat.createdAt,
    });

    // ✅ 대화시작유저 / 상대유저 나의채팅방 컬렉션 업데이트
    db.collection("users")
      .doc(firstUID)
      .collection("myChats")
      .doc(chatRoomID)
      .update({
        lastText: newChat.text,
        lastTime: newChat.createdAt,
      });

    db.collection("users")
      .doc(oppUID)
      .collection("myChats")
      .doc(chatRoomID)
      .update({
        lastText: newChat.text,
        lastTime: newChat.createdAt,
      });
  });

// 🚀 [LISTEN] 나의 채팅방 컬렉션 생성
export const listenAddMyChats = functions
  .region("asia-northeast3")
  .firestore.document("users/{uid}/myChats/{cid}")
  .onCreate(async (snapshot, context) => {
    const cid = context.params.cid; // 채팅방 id
    const [firstUID, oppUID] = cid.split("000"); // 대화유저 id
    const db = admin.firestore();

    // ✅ 두 유저의 채팅방 정보
    const chatRoom = (await db.collection("chatRooms").doc(cid).get()).data();

    // ✅ 대화시작유저 / 상대유저 나의채팅방 컬렉션 업데이트
    if (chatRoom) {
      await db
        .collection("users")
        .doc(firstUID)
        .collection("myChats")
        .doc(cid)
        .update({
          lastText: chatRoom.lastText,
          lastTime: chatRoom.lastTime,
        });

      await db
        .collection("users")
        .doc(oppUID)
        .collection("myChats")
        .doc(cid)
        .update({
          lastText: chatRoom.lastText,
          lastTime: chatRoom.lastTime,
        });
    }
  });
