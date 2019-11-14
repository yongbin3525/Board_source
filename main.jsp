<%--
  Created by IntelliJ IDEA.
  User: yongbin3525
  Date: 2019-11-10
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="user1.User1" %>
<%@ page import="user1.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=divice-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
    <title>게시판</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }
%>
<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">게시판</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li class="active"><a href="main.jsp">메인</a></li>
            <li><a href="bbs.jsp">자유게시판</a></li>
            <li><a href="top5.jsp">TOP 5</a></li>
            
        </ul>
        <%
            if(userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
            } else {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                    <%
                        if(userID.equals("admin")){
                    %>
                    <li><a href="listAction.jsp">회원목록</a></li>
                     <li><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAllAction.jsp">게시물 전체삭제</a></li>
                    <%
                        }
                    %>
                </ul>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>
<%
    if(userID==null){
%>
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1>이런 게 시판</h1>
            <p>안녕하새오 저는 게시판이애오 글을 써주새오 아 글 쓰기 저네 로그인 하새오↗↗↗<br> 저기 위에 있어오 그럼 20000</p>
        </div>
    </div>
</div>
<%
    } else {
%>
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1>이런 게 시판</h1>
            <p>오 로그인 했내요
                <%
                    UserDAO userDAO = new UserDAO();
                    String name = userDAO.UserName(userID);
                    out.print(name);
                %>님 반가워오. 이제 글이나 쓰새오</p>
        </div>
    </div>
</div>
<%
    }
%>
<div class="container">
    <img src="images/main.jpg" style="margin-left: 90px">
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

