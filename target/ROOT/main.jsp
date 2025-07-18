<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>YCU Movies</title>
    <link rel="icon" type="image/x-icon" href="img/logo.png">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="font/iconfont.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/mainstyle.css">

</head>

<style>
    /* Make the image fully responsive */
    .carousel-inner img {
        width: 100%;
        /* height: auto;*/
        /* max-width: 100%; */
        max-height: 500px;
    }

    body {
        /*  字体  */
        font-family: -apple-system, BlinkMacSystemFont, 'Microsoft YaHei', sans-serif;

        /*  字号 */
        font-size: 16px;

        /*  字体颜色  */
        color: #333;

        /* 行距 */

        font-weight: 400;
    }

    .box {
        background: linear-gradient(#ff0b30, #343a40);
        font-family: 'Merriweather Sans', sans-serif;
        border-radius: 7px;
        position: relative;
        overflow: hidden;
    }

    .box:before {
        content: "";
        background: -webkit-repeating-linear-gradient(45deg, rgba(0, 0, 0, 0.1) 10px, transparent 10px, transparent 20px, rgba(0, 0, 0, 0.1) 20px, rgba(0, 0, 0, 0.1) 30px, transparent 30px, transparent 40px, rgba(0, 0, 0, 0.1) 40px, rgba(0, 0, 0, 0.1) 50px, transparent 50px, transparent 60px, rgba(0, 0, 0, 0.1) 60px, rgba(0, 0, 0, 0.1) 70px, transparent 70px, transparent 80px, rgba(0, 0, 0, 0.1) 80px, rgba(0, 0, 0, 0.1) 90px, transparent 90px);
        width: 100%;
        height: 100%;
        opacity: 0;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 0;
        transition: all 0.5s;
    }

    .box:hover:before {
        opacity: 1;
    }

    .box img {
        width: 100%;
        height: auto;
        transition: all 0.5s ease;
        -webkit-clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
        clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
    }

    .box:hover img {
        opacity: 0.5;
        -webkit-clip-path: polygon(50% 0, 99% 50%, 50% 99%, 0 50%);
        clip-path: polygon(50% 0, 99% 50%, 50% 99%, 0 50%);
    }

    .box .box-content {
        color: #fff;
        text-align: center;
        width: 100%;
        opacity: 0;
        transform: translateX(-50%) translateY(-50%) rotate(-55deg);
        position: absolute;
        top: 50%;
        left: 50%;
        z-index: 1;
        transition: all 0.5s;
    }

    .box:hover .box-content {
        opacity: 1;
        transform: translateX(-50%) translateY(-50%) rotate(0deg);
    }

    .box .title {
        font-size: 25px;
        font-weight: 700;
        text-transform: uppercase;
        text-shadow: 0 0 5px #000;
        margin: 0 0 3px 0;
    }

    .box .post {
        font-size: 16px;
        text-shadow: 0 0 5px #000;
        text-transform: capitalize;
        display: block;
    }

    .box .icon {
        padding: 0;
        margin: 0;
        list-style: none;
        opacity: 0;
        transform: rotateX(180deg);
        position: absolute;
        right: 10px;
        top: 10px;
        transition: all 0.3s;
    }

    .box:hover .icon {
        opacity: 1;
        transform: rotate(0);
    }

    .box .icon li a {
        /*color: #4A00E0;*/
        background-color: #fff;
        font-size: 17px;
        text-align: center;
        line-height: 30px;
        width: 30px;
        height: 30px;
        margin: 0 0 7px;
        border-radius: 50%;
        display: block;
        transition: all .5s;
    }

    .box .icon li a:hover {
        color: #8E2DE2;
        box-shadow: 0 0 15px #fff;
    }

    @media only screen and (max-width: 990px) {
        .box {
            margin: 0 0 30px;
        }
    }

    @media only screen and (max-width: 479px) {
        .box .title {
            font-size: 20px;
        }
    }
</style>

<body class="bg-dark" onload="disablePageBack()">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script>
    var msg;
    function checkUserOnline() {
        $.ajax({
            type: "POST",
            url: "checkUserOnline",
            data: {},
            success: function (data) {
                msg = data;
                console.log(msg);
            }
        });

        if (msg === 'null' || msg === '' || msg === undefined) {
            return;
        } else {
            console.log(msg)
            alert(msg);
        }
    }

    function checkLogin() {
        console.log(msg);
       /* if (msg === 'null' || msg === '' || msg === undefined) {
            console.log("checkLogin()");
            check = setInterval("checkUserOnline()", 500);
        }*/

    }
    function disablePageBack() {
        //消除后退的所有动作。包括 键盘、鼠标手势等产生的后退动作。，用户登录到系统中后，浏览器回退按钮失效，只能点击退出按钮退出系统！
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }

</script>
<div id="main">

    <jsp:include page="headerMain.jsp"/>
    <section class="hero-area " id="home">
        <div class="container">
            <div class="hero-area-slider">
                <c:forEach var="hot" items="${hotMovies}">
                    <div class="row hero-area-slide bg-dark">
                        <div class="col-lg-6 col-md-5">
                            <div class="hero-area-content">
                                <img src="${hot.image}"
                                     alt="about"/>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-7">
                            <div class="hero-area-content pr-50">
                                <h2>${hot.name}</h2>
                                <div class="review mt-3">
                                    <h4>${hot.score}&nbsp;分</h4>
                                </div>
                                <p class="text-white">
                                        ${hot.des}
                                </p>
                                <div class="slide-trailor">
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="hero-area-thumb">
                <div class="thumb-prev">
                    <div class="row hero-area-slide bg-dark">
                        <div class="col-lg-6">
                            <div class="hero-area-content">
                                <img src="${hotMovies[1].image}" alt="about"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="hero-area-content pr-50">
                                <h2>${hotMovies[1].name}</h2>
                                <div class="review">
                                    <%--  <div class="author-review"><i class="icofont icofont-star"></i><i
                                              class="icofont icofont-star"></i><i class="icofont icofont-star"></i><i
                                              class="icofont icofont-star"></i><i class="icofont icofont-star"></i>
                                      </div>--%>
                                    <h4>${hotMovies[1].score}</h4>
                                </div>
                                <p class="text-white">
                                    ${hotMovies[1].des}
                                </p>
                                <div class="slide-trailor">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="thumb-next">
                    <div class="row hero-area-slide bg-dark">
                        <div class="col-lg-6">
                            <div class="hero-area-content">
                                <img src="${hotMovies[1].image}" alt="about"/></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="hero-area-content pr-50">
                                <h2>${hotMovies[1].name}</h2>
                                <div class="review">
                                    <%--<div class="author-review"><i class="icofont icofont-star"></i><i
                                            class="icofont icofont-star"></i><i class="icofont icofont-star"></i><i
                                            class="icofont icofont-star"></i><i class="icofont icofont-star"></i>
                                    </div>--%>
                                    <h4>${hotMovies[2].name}分</h4>
                                </div>
                                <p class="text-white">
                                    ${hotMovies[2].des}
                                </p>
                                <div class="slide-trailor">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="middle-show">
        <div class="middle-cont">
            <div class="middle-content" style="margin-top: 30px; ">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">最新电影</a>
                    </h2>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['最新']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>

                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor}</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">科幻</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['科幻']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor}</p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>


            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">喜剧</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['喜剧']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>


            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">动作</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">

                        <c:forEach var="m" items="${data['动作']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">剧情</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['剧情']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">动画</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['动画']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>


            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">恐怖</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['恐怖']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">悬疑</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['悬疑']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor}</p>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#">奇幻</a>
                    </h2>
                    <a href="/movie_bt_tags/science-fiction" class="moreb">更多>> </a>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <c:forEach var="m" items="${data['奇幻']}">
                            <li>
                                <div class="box">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}"
                                       style="height: 354.667px;">
                                        <img class="thumb lazy initial loaded" src="${m.image }"
                                             alt="">
                                    </a>
                                    <div class="box-content">
                                        <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            <h3 class="title">${m.name }</h3>
                                        </a>
                                        <br>
                                        <a href="${m.url}">
                                            <span class="iconfont iconbofang1" style="font-size: 2.5em;"></span>
                                        </a>
                                    </div>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                            ${m.name }</a>
                                </h4>
                                <p class="inzhuy">主演：${m.actor }</p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

        </div>
    </div>
    <script src="js/jquery.slicknav.min.js"></script><!-- owl carousel JS -->
    <script src="js/owl.carousel.min.js"></script><!-- Popup JS -->
    <script src="js/jquery.magnific-popup.min.js"></script><!-- Isotope JS -->
    <script src="js/isotope.pkgd.min.js"></script><!-- main JS -->
    <script src="js/main.js"></script>

    <jsp:include page="foot.jsp"/>
</div>


</body>

</html>