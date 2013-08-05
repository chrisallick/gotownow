document.addEventListener('DOMContentLoaded', function () {
    chrome.tabs.getSelected(null,function(tab) {
        var tablink = tab.url;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "http://gotonow.herokuapp.com/url", true);
        xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    document.innerHTML = "done";
                    self.close();
                }
            }
        }
        xhr.send('url='+tablink);
    });
});
