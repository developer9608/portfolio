<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    String path = request.getContextPath();
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="<%=path%>/css/include.css">
    <link rel="stylesheet" href="<%=path%>/css/total.css">
    <link rel="stylesheet" href="<%=path%>/css/datepicker.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<header>
    <div class="navbar-logo" align="left">
        <a href="<%=path %>/index.jsp">
            <img src="<%=path%>/img/Logo.png" alt="VeichleConnect">
            <font><b>VeichleConnect</b></font>
        </a>
    </div>
    <hr>
    <nav class="navbar">
        <div class="navbar-menu">
            <a href="<%=path%>/index.jsp">Home</a>
            <a href="<%=path%>/modelList.do">시승차량찾기</a>
            <c:if test="${login_id != null}">
                <a href="<%=path%>/getRezList.do">시승예약확인</a>
            </c:if>
            <c:if test="${login_role == 'ROLE_ADMIN'}">
                <a href="<%=path%>/manageModelList.do">차량등록관리</a>
                <a href="<%=path%>/getMemberList.do">회원권한관리</a>
                <a href="<%=path%>/modelForm.do">시승차량등록</a>
            </c:if>
        </div>
        <div class="navbar-user">
            <c:choose>
                <c:when test="${login_id != null}">
                    <a href="<%=path%>/getMember.do?memberLoginId=${login_id}">나의정보</a>
                    <a href="<%=path%>/logout.do">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="<%=path %>/login.do">로그인</a>
                    <a href="<%=path %>/joinForm.do">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>