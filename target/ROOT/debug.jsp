<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>数据调试页面</title>
</head>
<body>
    <h1>数据调试页面</h1>
    
    <c:forEach var="entry" items="${data}">
        <h2>分类: ${entry.key}</h2>
        <p>电影数量: ${entry.value.size()}</p>
        <c:if test="${entry.value.size() > 0}">
            <ul>
                <c:forEach var="movie" items="${entry.value}">
                    <li>
                        <strong>${movie.name}</strong><br>
                        图片路径: ${movie.image}<br>
                        类型: ${movie.type}<br>
                        年份: ${movie.years}<br>
                        <img src="${movie.image}" alt="${movie.name}" style="width: 100px; height: 150px; border: 1px solid #ccc;">
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <hr>
    </c:forEach>
</body>
</html>
