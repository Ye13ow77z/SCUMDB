<%@ page import="domain.User" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>电影详情页</title>
    <link rel="stylesheet" href="font/iconfont.css">
    <link rel="icon" type="image/x-icon" href="img/logo.png">
    <link rel="stylesheet" href="css/comment.css"/>
    <link rel="stylesheet" href="css/sinaFaceAndEffec.css"/>
    <link rel="stylesheet" href="css/dreamlike.css"/>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/info.css">

</head>
<style>
    body {
        /*  字体  */
        font-family: -apple-system, BlinkMacSystemFont, 'Microsoft YaHei', sans-serif;

        /*  字号 */
        font-size: 16px;

        /*  字体颜色  */
        color: #333;

        /* 行距 */
        line-height: 1.75;
    }
</style>
<body class="bg-dark">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/comment.js"></script>
<script type="text/javascript" src="js/sinaFaceAndEffec.js"></script>
<div id="atome" class="atome">
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
</div>
<div id="main" class="d-none">
    <jsp:include page="header.jsp"/>

    <div class="mid" style="margin-top: 10px">
        <!--电影详情 开始 -->
        <div class="row detail-info" style="height: 500px;">
            <div class="col-md-6 detail">
                <p id="movieName" class="d-none">${detail.name}</p>
                <img src="${detail.image }" alt="" style="border: 5px solid gray;">
                <table class="info">
                    <tr class="info-tr">
                        <td>上映日期</td>
                        <td>${detail.years}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>导演</td>
                        <td>${detail.director}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>地区</td>
                        <td>${detail.country}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>类型</td>
                        <td>${detail.type }</td>
                    </tr>
                    <tr class="info-tr">
                        <td>主演</td>
                        <td><span style=" text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 8;
    overflow: hidden;">${detail.actor }
                        </span></td>
                    </tr>
                    <tr class="info-tr">
                        <td>评分</td>
                        <td>${detail.score }分</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <div class="juqing">
                    <h3>${detail.type}</h3>
                </div>
                <span style="
                    width: auto;
                    text-overflow:ellipsis;  
                    display: -webkit-box;
                    -webkit-box-orient: vertical;
                     -webkit-line-clamp:9;
                     overflow: hidden;">
                    ${detail.des } </span>

                <div class="float-right">
                    <a class="btn btn-success" href="${detail.url}" role="button">
                        <span class="">&nbsp;在线播放</span>
                    </a>
                </div>
            </div>
            <!-- 电影详情 结束 -->

        </div>
        <!-- Large modal -->
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div id="content" style="width: 700px; height: auto;">
                        <div class="wrap">
                            <div class="comment">
                                <div class="content">
                                    <div class="cont-box">
                                        <textarea class="text" placeholder="请输入..." id="description"></textarea>
                                    </div>
                                    <div class="tools-box">
                                        <div class="operator-box-btn">
                                            <span class="face-icon" style="margin-top: -5px">☺</span>
<%--                                            <span class="img-icon" style="margin-top: -15px">▧</span>--%>
                                        </div>
                                        <div class="submit-btn">
                                            <input type="button" onClick="addComment()" value="提交评论"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- <div id="info-show">
                                 <ul></ul>
                             </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 评论部分 开始 -->
        <div class="row" style="background: white;">
            <div class="row" style="width: 100%;">
                <div class="col-md-12">
                    <%
                        User user = (User) request.getSession().getAttribute("user");
                        if (user == null) {

                    %>
                    <a href="${pageContext.request.contextPath}/login.do" class="float-right text-muted">
                        <span style="font-size: 1.2em;" data-toggle="modal" data-target=".bd-example-modal-lg">评论</span>
                    </a>
                    <%
                    } else {


                    %>
                    <a href="#" class="float-right text-muted">
                        <span style="font-size: 1.2em;" data-toggle="modal" data-target=".bd-example-modal-lg">评论</span>
                    </a>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="row">
                <div class="row comment" style="width: 100%;">
                    <c:forEach var="comment" items="${comments}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count <= 4}">
                                <div class="c-info ml-5 mr-5 mt-5">
                                    <div class="row">
                                        <!-- 头像图片 -->
                                        <div class="col-md-3">
                                            <img src="img/bg2.png"
                                                 alt="140*140"
                                                 class="rounded-circle mt-2" width="80px" height="80px">
                                        </div>
                                        <div class="col-md-8">
                                            <h4>${comment.userName}</h4>
                                            <span style="color: gray;">${comment.addTime}</span>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="hid des">
                                                    ${comment.description}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="c-info ml-5 mr-5 d-none mt-5">
                                    <div class="row">
                                        <!-- 头像图片 -->
                                        <div class="col-md-3">
                                            <img src="https://www.runoob.com/try/bootstrap/layoutit/v3/default3.jpg"
                                                 alt="140*140"
                                                 class="rounded-circle mt-2" width="80px" height="80px">
                                        </div>
                                        <div class="col-md-8">
                                            <h4>${comment.userName}</h4>
                                            <span style="color: gray;">${comment.addTime}</span>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="hid des">
                                                    ${comment.description}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
            <div class="row" style=" width: 100%; margin-top: 10px;">
                <c:if test="${commentsSize > 0}">
                    <div class="col-md-12" style="text-align: center;">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center" id="controllPage">
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Previous"
                                       onclick="lastCommentPage();return false;">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <%
                                    for (int i = 0; i < (int) request.getAttribute("commentsSize"); i++) {


                                %>
                                <%
                                    if (i == 0) {
                                %>
                                <li class="page-item active" onclick="changeCommentPage(<%=i+1%>)">
                                    <a class="page-link" href="#"><%=i + 1%>
                                    </a>
                                </li>
                                <%
                                } else {
                                %>
                                <li class="page-item" onclick="changeCommentPage(<%=i+1%>)">
                                    <a class="page-link" href="#"><%=i + 1%>
                                    </a>
                                </li>
                                <%
                                    }
                                %>
                                <%
                                    }
                                %>
                                <li class="page-item">
                                    <a class="page-link" href="#" onclick="nextPageComment();return false;"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
            <!-- 评论部分 结束 -->
        </div>

        <!-- 热门电影 开始 -->
        <div class="row bottom-menu">
            <div class="row">
                <!-- 标题 -->
                <div class="col-md-12">
                    <h3 class="hot-title">
                        热门电影
                    </h3>
                </div>
                <div class="col-md-12">
                    <ul class="list-unstyled hot-movie">
                        <c:forEach var="movie" items="<%=request.getAttribute(\"hotMovies\") %>" varStatus="status">
                            <li>
                                <div style="text-align: center;">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${movie.name}"
                                       style="height: 354.667px;">
                                        <img src="${movie.image}" alt="">
                                        <span style="display: block; position: relative; background: black;
											margin-top: -40px; height: 40px; line-height: 40px; opacity: 0.7;
											color: white;">${movie.name}</span>
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="row more-info" style="width: 100%;">
                <div class="col-md-12" style="text-align: center;">
                    <a class="btn btn-default"
                       href="${pageContext.request.contextPath}/category.do?category=${detail.type}"
                       role="button"
                       style="font-size: 1.2em; border-radius: 20px; width: 150px; background:#f6c624;"><strong>查看更多</strong></a>
                </div>
            </div>
            <!-- 热门电影 结束 -->

        </div>

        <script type="text/javascript">
            // 绑定表情
            $('.face-icon').SinaEmotion($('.text'));

            /*
            // 测试本地解析
            function out() {
                var inputText = $('.text').val();
                console.log(inputText);
                $('#info-show ul').append(reply(AnalyticEmotion(inputText)));

            }

            var html;

            function reply(content) {
                console.log("content: " + content);
                // html = '<li>';
                //  html += '<div class="head-face">';
                //  html += '<img src="images/bg2.png" / >';
                //  html += '</div>';
                //  html += '<div class="reply-cont">';
                //  html += '<p class="username">小小红色飞机</p>';
                //  html += '<p class="comment-body">' + content + '</p>';
                //  html += '<p class="comment-footer">2016年10月5日　回复　点赞54　转发12</p>';
                //  html += '</div>';
                //  html += '</li>';
                var newEle = '<p>';
                newEle += content;
                newEle += '</p>';
                return newEle;
            }
            */
            function addComment() {
                var description = $("#description").val();
                var movieName = $("#movieName").text();
                console.log(description + " " + movieName);
                $.ajax({
                    url: "comment.do",
                    data: "description=" + description + "&movieName=" + movieName,
                    type: "POST",
                    success: function (data) {
                        if (data === "ok") {
                            //刷新当前页面.
                            window.location.reload();
                        }
                    },
                    error: function (e) {
                        console.log(e)
                    }
                })
            }

            function transform() {
                $(".des").each(function () {
                    var info = $(this).text().trim();
                    var newInfo = AnalyticEmotion(info);
                    console.log("newInfo: " + newInfo);
                    $(this).text("");
                    var newEle = '<p>';
                    newEle += newInfo;
                    newEle += '</p>';
                    $(this).append(newEle)
                });
                return true;

            }

            $(window).on('load', function () {
                var flag = transform();
                console.log("flag:"+flag);
                // 如果表情图片已经获取到了，则显示
                if(flag){
                    $("#atome").addClass("d-none");
                    $("#main").removeClass("d-none")
                }


            });
        </script>
        <script>
            var $c_info = $(".c-info");
            var pos = 1;

            // 显示上一页评论
            function lastCommentPage() {
                var length = $("#controllPage li").length;
                console.log("length: " + length);
                console.log("pos: " + pos);
                if (pos - 1 === 0) {
                    return false;
                }
                $("#controllPage li").each(function (index) {
                    // 如果有 active属性，则表示是当前页面
                    if ($(this).hasClass("active")) {
                        pos = index - 1;
                        $c_info.each(function (index) {
                            // 如果有 d-none属性，则表示是隐藏的评论，将前4个隐藏的评论显示出来
                            // 原本显示的4个评论隐藏起来
                            if ($(this).hasClass("d-none")) {
                                if ((index < pos * 4) && (index >= (pos - 1) * 4)) {
                                    $(this).removeClass("d-none")
                                }
                            } else {
                                $(this).addClass("d-none");
                            }
                        });
                        $(this).removeClass("active");
                    }
                });
                console.log("pos later: " + pos);
                $("#controllPage").find("li").eq(pos).addClass("active");

            }

            // 显示下一页评论
            function nextPageComment() {
                var length = $("#controllPage li").length;
                console.log("length: " + length);
                console.log("pos: " + pos);
                if (pos + 2 >= length) {
                    return false;
                }
                $("#controllPage li").each(function (index) {
                    // 如果有 active属性，则表示是当前页面
                    if ($(this).hasClass("active")) {
                        pos = index + 1;
                        $c_info.each(function (index) {
                            console.log(index)
                            // 如果有 d-none属性，则表示是隐藏的评论，将前4个隐藏的评论显示出来
                            // 原本显示的4个评论隐藏起来
                            if ($(this).hasClass("d-none")) {
                                if ((index < pos * 4) && (index >= (pos - 1) * 4)) {
                                    $(this).removeClass("d-none")
                                }
                            } else {
                                $(this).addClass("d-none");
                            }
                        });
                        $(this).removeClass("active");
                    }
                });
                console.log("pos later:" + pos);
                $("#controllPage").find("li").eq(pos).addClass("active");
            }

            // 显示点击页数对应的评论
            function changeCommentPage(pos) {
                var $lis = $("#controllPage li");
                var activeIndex = $lis.filter(".active").index();
                console.log(activeIndex);
                if (pos !== activeIndex) {
                    $lis.removeClass("active");
                    $lis.eq(pos).addClass("active");
                    $c_info.each(function (index) {
                        // 如果有 d-none属性，则表示是隐藏的评论，将前4个隐藏的评论显示出来
                        // 原本显示的4个评论隐藏起来
                        if ($(this).hasClass("d-none")) {
                            if ((index < pos * 4) && (index >= (pos - 1) * 4)) {
                                $(this).removeClass("d-none");
                            }
                        } else {
                            $(this).addClass("d-none");
                        }
                    });
                }


            }
        </script>
        <jsp:include page="foot.jsp"/>
    </div>
</body>

</html>