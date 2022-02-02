<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>

<c:set var="action" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commCrt" value="${ForwardConst.CMD_CREATE.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>スケジュール</h2>

        <div class="calendar"></div>

        <p><a href="<c:url value='?action=${action}&command=${commIdx}' />">一覧に戻る</a></p>


        <script>
        (function() {
            'use strict';

            const calendarEl = document.querySelector('.calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                navLinks: true,
                businessHours: true,
                editable: true,
                locale: 'ja',
                events: [
                    <c:forEach var="report" items="${reports}" varStatus="status">
                     {
                         <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="createDay" type="date" />
                         start :'<fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd" />T<c:out value="${report.startTime}"  />:00',
                         end :' <fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd" />T<c:out value="${report.endTime}" />:00',
                         display: 'background',
                         color: '#ff9f89'
                     } ,
                </c:forEach>
                    {
                    title: '旅行',
                    start: '2020-12-26',
                    end: '2020-12-31'
                  }
                ]
            });

            calendar.render();
        }());




        </script>

    </c:param>
</c:import>
