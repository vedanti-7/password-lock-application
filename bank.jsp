<%@ page import="java.sql.*, java.io.*" %>

<% 
String username = (String) session.getAttribute("username");
String email = (String) session.getAttribute("email"); 
Integer id = (Integer) session.getAttribute("user_id");
%>

<p>Welcome, <%= username %></p>
<p>Your Email: <%= email %></p>
<p>Your User ID: <%= id %></p>

<%!
public static String encryption(String s, int key)
{
    char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    StringBuilder c = new StringBuilder();
    
    for(int i=0;i<s.length();i++)
    {
        char ch = s.charAt(i);
        for(int j=0;j<26;j++)
        {
            if(ch==alphabets[j])
            {
                int pos=j;
                int inc = pos+key;
                c.append(alphabets[inc]);
            }
        }
    }
    return c.toString();
}
%>

<%!
public static int[] num_to_arr(int n)
{
    int temp = n;
    int len = 0;
    while(temp!=0)
    {
        temp=temp/10;
        len++;
    }
    int index = len-1;
    int[] b = new int[len];
    while (n != 0) {
        b[index] = n % 10;  
        n = n / 10;      
        index--;
    }
    return b;
}
%>

<%!
public static String encryption(int n[],int size)
{
    char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    StringBuilder c = new StringBuilder();
    
    for(int i=0;i<size;i++)
    {
        if(n[i]>=0 && n[i]<=26)
        {
            c.append(alphabets[n[i]]);
        }
    }
    return c.toString();
}
%>

<% 
Connection con = null;
PreparedStatement pt = null;
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
    if(con!=null)
    {
        out.println("connection successful");
    }

    int cust_id = Integer.parseInt(request.getParameter("cust_id"));
    String pwd = request.getParameter("pwd");
    int ifsc_code = Integer.parseInt(request.getParameter("ifsc_code"));
    String br_name = request.getParameter("br_name");

    int[] cust_id_arr = num_to_arr(cust_id);
    int[] ifsc_code_arr = num_to_arr(ifsc_code);


    String encryptedPwd = encryption(pwd,3);
    String encryptedBr_name = encryption(br_name,3);
    String encryptedCust_id = encryption(cust_id_arr,3);
    String encryptedIfsc_code = encryption(ifsc_code_arr,3);

    pt = con.prepareStatement("INSERT INTO bank(c_id,password,IfscCode,branch_name) VALUES (?,?,?,?)");
    pt.setString(1, encryptedCust_id);
    pt.setString(2, encryptedPwd);
    pt.setString(3, encryptedIfsc_code);
    pt.setString(4, encryptedBr_name);

    int rows = pt.executeUpdate();
    if(rows>0)
    {
        out.println("data inserted !!");
    }
    else
    {
        out.println("data not inserted");
    }
}
catch(Exception e)
{
    out.println("error :"+e.getMessage());
}
finally
{
    try
    {
        if (pt != null) pt.close();
        if (con != null) con.close();
    } 
    catch (SQLException ex)
    {
        out.println("Error while closing resources: " + ex.getMessage());
    }
}
%>
<html>
    <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="Home.css">
    </head>
<body>
    



    

    <section class="bg-white dark:bg-gray-900 min-h-screen flex flex-col justify-center items-center">
        <!-- First Section -->
        <div class="w-full max-w-screen-lg flex flex-col md:flex-row items-center justify-between px-6 py-8">
            <!-- Left Content -->
            <div class="md:w-1/2 text-left">
                <h1 class="mb-8 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
                    Enter your details
                </h1>
                <p class="mb-8 text-lg font-normal text-gray-500 lg:text-xl dark:text-gray-400">
                    Store your crucial bank details here. Maximise the security of your confidential details.
                </p>
                <form class="w-full space-y-4" action="gen" method="GET">
                    <button type="submit" class="py-3 px-5 text-sm font-medium text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none rounded-lg">
                        About us 
                    </button>
                </form>
            </div>
            <!-- Right Form -->
            <div class="md:w-1/2 max-w-md px-6">
                <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 w-full">
                    <form class="w-full space-y-4" action="bank" method="POST">
                        <div class="relative">
                            <input type="number" id="cust_id" name="cust_id" class="block w-full p-3 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white" placeholder="Enter customer_id..." required />
                        </div>
                        <div class="relative">
                            <input type="text" id="pwd" name="pwd" class="block w-full p-3 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white" placeholder="Enter password..." required />
                        </div>
                        <div class="relative">
                            <input type="number" id="ifsc_code" name="ifsc_code" class="block w-full p-3 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white" placeholder="Enter your IFSC_code.." required />
                        </div>
                        <div class="relative">
                            <input type="text" id="br_name" name="br_name" class="block w-full p-3 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white" placeholder="Enter your branch_name.." required />
                        </div>
                        <div class="relative">
                            <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none font-medium rounded-lg text-sm px-4 py-2">
                                Lock details
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>



        <section class="w-full h-[300px] bg-cover bg-center bg-no-repeat bg-[url('https://flowbite.s3.amazonaws.com/docs/jumbotron/conference.jpg')] bg-gray-700 bg-blend-multiply">
            <div class="px-4 mx-auto max-w-screen-xl text-center py-12 lg:py-24">
                <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
                </div>
            </div>
        </section>
        
        <!-- Second Section -->
        <div class="w-full max-w-screen-lg flex flex-col md:flex-row items-center justify-between px-6 py-8 mt-16 lg:mt-24">
            <!-- Left Content -->
            <div class="md:w-1/2 text-left">
                <h1 class="mb-8 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
                    Want to have your details?
                </h1>
                <p class="mb-8 text-lg font-normal text-gray-500 lg:text-xl dark:text-gray-400">
                    Store your crucial bank details here. Maximise the security of your confidential details.
                </p>
                <form class="w-full space-y-4" action="gen" method="GET">
                    <button type="submit" class="py-3 px-5 text-sm font-medium text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none rounded-lg">
                        About us 
                    </button>
                </form>
            </div>
            <!-- Right Form -->
            <div class="md:w-1/2 max-w-md px-6">
                <div class="bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-8 md:p-12 w-full">
                    <form class="w-full space-y-4" action="bkstr" method="POST">
                        <div class="relative">
                            <input type="number" id="client_id" name="client_id" class="block w-full p-3 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white" placeholder="Enter your id..." required />
                        </div>
                        <div class="relative">
                            <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none font-medium rounded-lg text-sm px-4 py-2">
                                Unlock details
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

</body>
</html>
