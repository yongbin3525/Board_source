<%--
  Created by IntelliJ IDEA.
  User: yongbin3525
  Date: 2019-11-10
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="comment.CommentDAO" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=divice-width" initial-scale="1">
    <title>게시판</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int commentNum = 0;
    if (request.getParameter("commentNum") != null) {
        commentNum = Integer.parseInt(request.getParameter("commentNum"));
    }
    int bbsID = 0;
    if (request.getParameter("commentNum") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    CommentDAO commentDAO = new CommentDAO();
    int result = commentDAO.delete(commentNum);
    BbsDAO bbsDAO = new BbsDAO();
    bbsDAO.viewMinusCount(bbsID);
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글 삭제에 실패했습니다')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
        script.println("</script>");
    }


%>
</body>
</html>

