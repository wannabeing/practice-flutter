import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// 🚀 [LISTEN] 비디오모델 생성
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

// 🚀 [LISTEN] 좋아요모델 생성
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

// 🚀 [LISTEN] 좋아요모델 삭제
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
