<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneId"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="ja_JP" />
<%!private static Map eventMap = new HashMap();
	static {
		eventMap.put("20240101", "お正月");
		eventMap.put("20240108", "成人の日");
		eventMap.put("20240211", "建国記念日");
		eventMap.put("20240223", "天皇誕生日");
		eventMap.put("20240320", "春分の日");
		eventMap.put("20240429", "昭和の日");
		eventMap.put("20240503", "憲法記念日");
		eventMap.put("20240504", "みどりの日");
		eventMap.put("20240505", "こどもの日");
		eventMap.put("20240715", "海の日");
		eventMap.put("20240811", "山の日");
		eventMap.put("20240916", "敬老の日");
		eventMap.put("20240922", "秋分の日");
		eventMap.put("20241014", "スポーツの日");
		eventMap.put("20241103", "文化の日");
		eventMap.put("20241123", "勤労感謝の日");
		eventMap.put("20241225", "クリスマス");
		eventMap.put("20241231", "大晦日");
	}%>
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
LocalDate localDate;
if (year == null || month == null || day == null) {
	localDate = LocalDate.now();
} else {
	localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
year = String.valueOf(localDate.getYear());
month = String.format("%02d", localDate.getMonthValue()); // ゼロ埋め
day = String.format("%02d", localDate.getDayOfMonth()); // ゼロ埋め

request.setAttribute("year", year);
request.setAttribute("month", month);
request.setAttribute("day", day);
request.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

String event = (String) eventMap.get(year + month + day);
request.setAttribute("event", event);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calender</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="POST" action="/jsp/calender.jsp">
		<ul>
			<li><input type="text" name="year" value="${year}" /><label
				for="year">年</label>
			<li><input type="text" name="month" value="${month}" /><label
				for="month">月</label>
			<li><input type="text" name="day" value="${day}" /><label
				for="day">日</label></li>
			<li><input type="submit" value="送信" /></li>
			<li><c:out value="${year} / ${month} / ${day}" />(<fmt:formatDate
					value="${date}" pattern="E" />)</li>
			<li><c:out value="${event}" /></li>
		</ul>
	</form>
</body>
</html>


