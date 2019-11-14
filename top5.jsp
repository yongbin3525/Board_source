<%--
  Created by IntelliJ IDEA.
  User: yongbin3525
  Date: 2019-11-10
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=divice-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
    <title>게시판</title>
    <style type="text/css">
        a, a:hover {
            color: #000000;
            text-decoration: none;
        }
    </style>
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
            <li><a href="main.jsp">메인</a></li>
            <li><a href="bbs.jsp">자유게시판</a></li>
            <li class="active"><a href="top5.jsp" >TOP 5</a></li>

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
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1>TOP 5</h1>
            <p>탑 빠이브 개시판 이애오 조와요가 1 이상인 개시글들 중 좋아요가 제일 많은 5개의 개시물이애오</p>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th style="background-color: #eeeeee; text-align: center;">순위</th>
                    <th style="background-color: #eeeeee; text-align: center;">제목</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                    <th style="background-color: #eeeeee; text-align: center;">조회수</th>
                    <th style="background-color: #eeeeee; text-align: center;">좋아요</th>
                </tr>
            </thead>
            <tbody>
            <%
                BbsDAO bbsDAO = new BbsDAO();
                ArrayList<Bbs> list = bbsDAO.getRankList();
                if(list.size()>=5){
                    for(int i=0; i<5; i++){
            %>
                <tr>
                    <td><%= (i+1) %></td>
                    <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
                    <td><%= list.get(i).getUserID() %></td>
                    <td><%= list.get(i).getBbsDate() %></td>
                    <td><%= list.get(i).getBbsview() %></td>
                    <td><%= list.get(i).getBbsLike() %></td>
                </tr>
            <%
                }
                }else {
                    for(int i=0; i<list.size(); i++){
            %>
            <tr>
                <td><%= (i+1) %></td>
                <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
                <td><%= list.get(i).getUserID() %></td>
                <td><%= list.get(i).getBbsDate() %></td>
                <td><%= list.get(i).getBbsview() %></td>
                <td><%= list.get(i).getBbsLike() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

