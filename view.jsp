<%--
  Created by IntelliJ IDEA.
  User: yongbin3525
  Date: 2019-11-10
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="user1.UserDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
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
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.viewCount(bbsID);
		
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">게시판</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">자유게시판</a></li>
				<li><a href="top5.jsp">TOP 5</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
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
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">글 제목</td>
						<td colspan="2" style="text-align : left;"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2" style="text-align : left;"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2" style="text-align : left;"><%=bbs.getBbsDate()%></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td colspan="2" style="text-align : left;"><%=bbs.getBbsview()%></td>
					</tr>
					<tr>
						<td>좋아요</td>
						<td colspan="2" style="text-align : left;"><%=bbs.getBbsLike()%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
				</tbody>
			</table>
			<div class="container">
				<div class="row">
					<table class="table"
						   style="text-align: center; border: 1px solid #dddddd">
						<tbody>
						<%
							CommentDAO commentDAO= new CommentDAO();
							ArrayList<Comment> list = commentDAO.getList(bbsID);
							for(int i=0; i<list.size(); i++){
						%>
						<tr>
							<td colspan="2" style="text-align : center; width: 100px"><%=list.get(i).getUserName()%></td>
							<%
								if(list.get(i).getUserID().equals("admin")){
							%>
							<td style="text-align : left; width: 800px; color: cornflowerblue"><h3><strong><%=list.get(i).getComment1().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
									.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></strong></h3></td>
							<%
								} else {
							%>
							<td style="text-align : left; width: 800px;"><%=list.get(i).getComment1().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
									.replaceAll("\n", "<br>")%></td>
							<%
								}
							%>
							<td style="text-align : right; width: 200px"><%=list.get(i).getCdate()%></td>
							<%
								int commentNum = list.get(i).getCommentNum();
								if (userID != null &&(userID.equals(list.get(i).getUserID()) || userID.equals("admin"))) {
							%>
							<td><a href="commentUpdate.jsp?commentNum=<%=commentNum%>&bbsID=<%=bbsID%>&comment1=<%=commentDAO.getComment(commentNum)%>" class="btn btn-success pull-right">수정</a>
							<a onclick="return confirm('정말로 삭제하시겠습니까?')"
							   href="commentDeleteAction.jsp?commentNum=<%=commentNum%>&bbsID=<%=bbsID%>" class="btn btn-warning pull-right">삭제</a>
							</td>
							<%
								}
							%>

						</tr>

						<%
							}
						%>
						</tbody>
					</table>

			<div class="container">
				<div class="row">
					<form method="post" action="commentAction.jsp?bbsID=<%=bbsID%>">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
							<tbody>
							<tr>
								<td>
									<textarea type="text" class="form-control" placeholder="댓글 내용" name="comment1" maxlength="2048" style="height: 120px; width: 946px "></textarea>
									<input type="submit" class="btn btn-primary pull-right" value="댓글 쓰기">
								</td>
							</tr>
							</tbody>
						</table>

					</form>
				</div>
			</div>
			<a href="bbs.jsp" class= "btn btn-primary">목록</a>
			<%
				UserDAO userDAO = new UserDAO();
				if (userID != null && ((userDAO.UserName(userID).equals(bbs.getUserID()) || userID.equals("admin")))) {
			%>
					<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')"
					   href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
					<%
						}
			%>
			 <a href="likeMinusAction.jsp?bbsID=<%=bbsID %>" class="btn btn-danger pull-right">싫어요</a>
			 <a href="likeAction.jsp?bbsID=<%=bbsID %>" class="btn btn-success pull-right">좋아요</a><p> </p>
			<%
				if (userID != null && userID.equals("admin")) {
			%>
					<a href="likeControlAction.jsp?bbsID=<%=bbsID %>" class="btn btn-default pull-right">좋아요 조작</a>
					<%
						}%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>

