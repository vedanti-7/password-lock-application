<%@ page import="java.sql.*, java.io.*" %>
<% 
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
    if(con!=null){
        out.println("connection successful");
    }

    int cust_id = Integer.parseInt(request.getParameter("cust_id"));
    String pwd = request.getParameter("pwd");
    int ifsc_code = Integer.parseInt(request.getParameter("ifsc_code"));
    String br_name = request.getParameter("br_name");

    PreparedStatement pt = con.prepareStatement("INSERT INTO bank(c_id,password,IfscCode,branch_name) VALUES (?,?,?,?)");
    pt.setInt(1, cust_id);
    pt.setString(2, pwd);
    pt.setInt(3, ifsc_code);
    pt.setString(4, br_name);

    int rows = pt.executeUpdate();
    if(rows>0)
    {
        out.println("data inserted !!");
    }
    else{
        out.println("data not inserted");
    }
}
catch(Exception e)
{
    out.println("error :"+e.getMessage());
}

%>
<html>
    <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="Home.css">
    </head>
<body>
    



    <section class="bg-white dark:bg-gray-900 h-screen flex items-center">

        <div class="py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16">
            <h1 class="mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Enter your details</h1>
            <p class="mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 lg:px-48 dark:text-gray-400">Store your crucial bank details here. Maximise the security of your confidential details.</p>
            <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
                <form class="w-full mx-auto space-y-4" action="gen" method="GET">
                    <div class="relative">
                        <button type="submit" class="py-3 px-5 text-sm font-medium text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                            About us 
                        </button>
                    </div>
                    
                </form>  
            </div>
        </div>

        <div class="py-8 px-4 mx-auto w-full lg:py-16">
            <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 w-full">
                <form class="w-full mx-auto space-y-4" action="bank" method="POST">
                    <div class="relative">
                        <input type="text" id="cust_id" name= "cust_id" class="block w-full p-3 pl-10 text-base border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Enter customer_id..." required />
                    </div>
                    
                    <div class="relative">
                        <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                            Lock details
                        </button>
                    </div>
                </form> 
            </div>
        </div>
    </section>
</body>
</html>
