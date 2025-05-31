<%@ page import="java.sql.*, java.io.*" %>
<%
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
    if(con!=null)
    {
        out.println("connection successful");
    }
    String uname = request.getParameter("name");
    String email = request.getParameter("email");
    out.println(uname);
    out.println(email);

    PreparedStatement pt = con.prepareStatement("INSERT INTO userentry(username,mail) VALUES(?,?)", Statement.RETURN_GENERATED_KEYS);
    pt.setString(1,uname);
    pt.setString(2,email);
    
    int rows=pt.executeUpdate();
    if(rows>0){
        ResultSet rs = pt.getGeneratedKeys();
        if(rs.next())
        {
            int generatedId = rs.getInt(1);
            session.setAttribute("user_id",generatedId);
            out.println("Inserted user ID: " + generatedId);
        }
        out.println("data inserted successfully");
        session.setAttribute("username",uname);
        session.setAttribute("email",email);
    }
    else{
        out.println("data not inserted");
    }
}
catch(Exception e)
{
    out.println("error : " + e.getMessage());
}
%>
<html>
    <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="Home.css">
    </head>
    <body>
        <section class="bg-white dark:bg-gray-900 h-screen flex items-center">
            <div class="py-8 px-4 mx-auto w-full lg:py-16">
                <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 mb-8 w-full">
                    <h1 class="text-gray-900 dark:text-white text-3xl md:text-5xl font-extrabold mb-2">Security is the key to privacy</h1>
                    <p class="text-lg font-normal text-gray-500 dark:text-gray-400 mb-6">Your secret is safe with us.</p>
                    <a href="#" class="inline-flex justify-center items-center py-2.5 px-5 text-base font-medium text-center text-white rounded-lg bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900">
                        About us
                        <svg class="w-3.5 h-3.5 ms-2 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
                        </svg>
                    </a>
                </div>

                <div class="grid md:grid-cols-2 gap-8 w-full">

                    <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 w-full">
                        <h2 class="text-gray-900 dark:text-white text-3xl font-extrabold mb-2">Bank</h2>
                        <p class="text-lg font-normal text-gray-500 dark:text-gray-400 mb-4">Store your crucial bank details here. Maximise the security of your confidential details. Lock provides you with the feature of storing your details as per different genre.</p>
                        <form class="w-full mx-auto space-y-4" action="bank" method="GET">
                            <div class="relative">
                                <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                    Lock details
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 w-full">
                        <h2 class="text-gray-900 dark:text-white text-3xl font-extrabold mb-2">General</h2>
                        <p class="text-lg font-normal text-gray-500 dark:text-gray-400 mb-4">Store your social media, general, and other additonal details here. Lock provides you with the feature of storing your details as per different genre.</p>
                        <form class="w-full mx-auto space-y-4" action="gen" method="GET">
                            <div class="relative">
                                <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                    Lock details
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        
    </body>
</html>
