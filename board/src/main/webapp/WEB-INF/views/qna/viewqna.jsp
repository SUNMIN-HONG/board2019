<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
</head> -->

<%@include file="../header.jsp"%>


	<div>

		<p>
			<br />
		<h5>${member.userName } 님 환영합니다.</h5>
		<img src="${pageContext.request.contextPath }${member.userImg }" style="max-width: 50px; min-width:30px; max-height:50px; height:auto; border: 1px solid black;">
		</p>

		
		<a href="/"> 홈화면 돌아가기</a>
		
	</div>
	<br />

	<form method="get">
	
	<div class="input-group input-group-sm mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroup-sizing-sm">카테고리</span>
			</div>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-sm" name="title"
				value="${view.category}" readonly />
		</div>

		<div class="input-group input-group-sm mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroup-sizing-sm">제목</span>
			</div>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-sm" name="title"
				value="${view.title}" readonly />
		</div>

		<div class="input-group input-group-sm mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroup-sizing-sm">작성자</span>
			</div>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-sm" name="writer"
				value="${view.writer}" readonly />
		</div>

		<!-- 12.02 add start -->
		<input type="hidden" class="form-control"
			aria-label="Sizing example input"
			aria-describedby="inputGroup-sizing-sm" name="writer"
			value="${view.writerId}" readonly />
		<!-- 12.02 add End -->


		
		<!-- 12.03 modify end --> 
		<!-- ---------------------------------------------------------------------------------- -->
		<!-- 12.09 modify st -->
		<div class="input-group">
			<div class="input-group-prepend" >
				<span class="input-group-text">내용</span>
			</div >
			<c:if test="${view.img != null}">
			<div style="align-content: center;">
				<img src="${pageContext.request.contextPath }${view.img }"
					class="img-fluid" alt="no image" style="max-width: 250px;" />
			</div>
		</c:if>
		
				<textarea class="form-control" aria-label="With textarea" cols="50"
					rows="5" name="content"  readonly>${view.content}
				</textarea>	

		</div>
		<!-- 12.03 modify end -->
		
		<!--  -->
		<!-- 12.03 modify st -->
		<%-- <c:if test="${view.imgUrl != null}">
		<div class="input-group">
			<div class="input-group-prepend" >
				<span class="input-group-text">파일받기</span>
			</div >
			
			<div style="align-content: center; line-height: 40px; ">
				&nbsp;<a href="../fileupload/filedown?name=${view.imgUrl}"> 파일 다운받기</a>
			</div>

		</div>
		
		</c:if> --%>
		<!-- 12.09 modify end -->
		<!--  -->
		
		
		<!-- ---------------------------------------------------------------------------------- -->		

	</form>
	
	<br />
	
	<!-- 댓글 보여주기 시작 -->
	<%
		int i = 1;
	%>

	<!--  -->
	<table class="table table-condensed" style="overflow: auto; ">

		<colgroup>
			<col width="10%">
			<col width="15%">
			<col width="20%">
			<col width="35%">
			<col width="10%">
		</colgroup>


		<thead class="thead-dark" style="text-align: center;">
			<tr>
				<th scope="col">순번</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">내용</th>
				
			</tr>
		</thead>

		<tbody>

			<c:forEach items="${replyList}" var="replyList">
				<tr style="text-align: center;">
					<td><%=i%></td>
					<td>${replyList.writer}</td>
					<td><fmt:formatDate value="${replyList.regDate}"
							pattern="MM/dd HH:mm" /><br /></td>
							<!-- word-break: break-all; word-wrap: break-word; 라인 정리 -->
					<td style="text-align: left;  height:auto;  overflow: auto;word-break: break-all; word-wrap: break-word; ">${replyList.content}</td>
					
				</tr>
				<%
					i++;
				%>
			</c:forEach>

		</tbody>

	</table>
<!--  -->

	



<%@include file="../footer.jsp"%>
