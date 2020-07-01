importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyAV2lbBXHwCBA4vOQOnZJJ3Xchw3Hr5TBM",
    authDomain: "oficina-ca325.firebaseapp.com",
    databaseURL: "https://oficina-ca325.firebaseio.com",
    projectId: "oficina-ca325",
    storageBucket: "oficina-ca325.appspot.com",
    messagingSenderId: "595774452413",
    appId: "1:595774452413:web:4f58c8abb90d87029f7dd4",
    measurementId: "G-01PFVSF1GD"
});
const messaging = firebase.messaging();
messaging.requestPermission()
.then(function(){
    console.log('Have permission');
})
.catch(function(err){
    console.log(err);
});
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});