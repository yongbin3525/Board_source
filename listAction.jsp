<%--
  Created by IntelliJ IDEA.
  User: yongbin3525
  Date: 2019-11-10
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="user1.UserDAO" %>
<%@ page import="user1.User1" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="css/custom.css">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=divice-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
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
            <li><a href="bbs.jsp" >자유게시판</a></li>
            <li><a href="top5.jsp">TOP 5</a></li>
        </ul>

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
                    <li><a href="deleteAllAction.jsp">유저 전체삭제</a></li>
                    <%
                        }
                    %>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #eeeeee; text-align: center;">유저 ID</th>
                <th style="background-color: #eeeeee; text-align: center;">유저 Password</th>
                <th style="background-color: #eeeeee; text-align: center;">유저 닉네임</th>
                <th style="background-color: #eeeeee; text-align: center;">성별</th>
                <th style="background-color: #eeeeee; text-align: center;">유저 이메일</th>
                <th style="background-color: #eeeeee; text-align: center;">아이디 생성일</th>
            </tr>
            </thead>
            <tbody>
            <%
                UserDAO userDAO = new UserDAO();
                ArrayList<User1> list = userDAO.getList();
                for(int i=0; i<list.size(); i++){
            %>
            <tr>
                <%
                    if(list.get(i).getUserID().equals("admin")){
                %>
                <td><%= list.get(i).getUserID() %></td>
                <%
                }
                    else{
                %>
                <td> <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteUserAction.jsp?UserID=<%=list.get(i).getUserID() %>"><%= list.get(i).getUserID()%></a></td>
                <%
                    }
                %>
                <td><%= list.get(i).getUserPassword() %></td>
                <td><%= list.get(i).getUserName() %></td>
                <td><%= list.get(i).getUserGender() %></td>
                <td><%= list.get(i).getUserEmail() %></td>
                <td><%= list.get(i).getCreateDate() %></td>
            </tr>
            <%
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

