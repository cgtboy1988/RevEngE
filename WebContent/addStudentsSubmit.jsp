<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@include file="./WEB-INF/includes/includes.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Tigress</title>

</head>

<body>
<%@include file="./WEB-INF/includes/mainPane.jsp" %>
<table id="inner_content">
	<%
        if(verbose)
        {
        	System.out.println("Got to hasUser conditional");
        }
        ArrayList emailList = new ArrayList();
        ArrayList fnameList = new ArrayList();
        ArrayList mnameList = new ArrayList();
        ArrayList lnameList = new ArrayList();
        ArrayList passwordList = new ArrayList();
        ArrayList courseList = new ArrayList();
		if(!hasUser || !(myUser.getAttribute("role").equals("admin")))
		{
			
		}
		else
		{
			Integer totalToAdd = new Integer(request.getParameter("totalAdd"));
			//out.print(totalToAdd);
			for(int x=0; x<=totalToAdd; x++)
			{
				//out.print(x);
				String email = request.getParameter("email_" + x);
				String fname = request.getParameter("fname_" + x);
				String mname = request.getParameter("mname_" + x);
				String lname = request.getParameter("lname_" + x);
				String password = request.getParameter("password_" + x);
				String course = request.getParameter("course_" + x);
				if(password.equals("Password: Do not change for an autogenerated value."))
				{
					password = UUID.randomUUID().toString();
				}
				myConnector.writeUser(email, email, fname, mname, lname, password, "student", (String)myUser.getAttribute("email"), course);
				emailList.add(email);
				fnameList.add(fname);
				mnameList.add(mname);
				lnameList.add(lname);
				passwordList.add(password);
				courseList.add(course);
				//out.print(password);
			}
		}
    %>
	<tr>
    	<td width="25%">
        
        </td>
        <td width="50%">
        <table class="inner_content_table">
        <tr>
        <td>
        <table class="news_table">
        <tr class="title_general">
        <td colspan="3" align="center">
        Students Added
        </td>
    	</tr>
    	<form id="csvExport" action="StudentCSVExport.csv" method="POST">
    	<tr>
    	<td width="100%">
    	Please export this data using the link below for your records.
    	</td>
    	</tr>
    	<tr>
    	<td width="100%">
    	<div align="center">
    	<input type="hidden" name="numStudents" value="<%=emailList.size() %>"></input>
    	<input type="submit" value="CSV Export"></input>
    	</div>
    	</td>
    	</tr>
        <tr>
        <td id="add_user_table">
        <%
        for(int x=0; x<emailList.size(); x++)
        {
        %>
        <input type="hidden" name="studentEmail_<%=x %>" value="<%=emailList.get(x) %>"></input>
        <input type="hidden" name="studentFname_<%=x %>" value="<%=fnameList.get(x) %>"></input>
        <input type="hidden" name="studentLname_<%=x %>" value="<%=lnameList.get(x) %>"></input>
        <input type="hidden" name="studentPassword_<%=x %>" value="<%=passwordList.get(x) %>"></input>
        <input type="hidden" name="course_<%=x %>" value="<%=courseList.get(x) %>"></input>
        <table class="news_item_table" width="100%">
        <tr>
        <td width="33%">
        Student:
        </td>
        <td width="67%">
        <%=x %>
        </td>
        </tr>
        <tr>
        <td width="33%">
        Email Address:
        </td>
        <td width="67%">
        <%=emailList.get(x) %>
        </td>
        </tr>
        <tr>
        <td width="33%">
        First Name:
        </td>
        <td width="67%">
        <%=fnameList.get(x) %>
        </td>
        </tr>
        <tr style="display:none;">
        <td width="33%">
        Middle Name:
        </td>
        <td width="67%">
        <%=mnameList.get(x) %>
        </td>
        </tr>
        <tr>
        <td width="33%">
        Last Name:
        </td>
        <td width="67%">
        <%=lnameList.get(x) %>
        </td>
        </tr>
        <tr>
        <td width="33%">
        Course:
        </td>
        <td width="67%">
        <%=courseList.get(x) %>
        </td>
        </tr>
        <tr>
        <td width="33%">
        Password:
        </td>
        <td width="67%">
        <%=passwordList.get(x) %>
        </td>
        </tr>
        </table>
        <%
        }
        %>
        </td>
        </tr>
        </form>
        </table>
        </td>
        </tr>
        </table>
        </td>
        <td width="25%">
        <table class="inner_content_table">
        
        </table>
        </td>
    </tr>
</table>
<%@include file="./WEB-INF/includes/footer.jsp" %>
</body>

</html>