

<%@ page import="java.sql.*, java.io.*" %>

<%! 
public static String decryption(String s, int key) {
    char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    StringBuilder c = new StringBuilder();
    
    for (int i = 0; i < s.length(); i++) {
        char ch = s.charAt(i);
        boolean found = false;
        for (int j = 0; j < 26; j++) {
            if (ch == alphabets[j]) {
                int pos = j;
                int dec = (pos - key + 26) % 26;
                c.append(alphabets[dec]);
                found = true;
                break;
            }
        }
        if (!found) {
            // If character is not a lowercase letter, keep it as it is
            c.append(ch);
        }
    }
    return c.toString();
}
%>

<%!
public static int[] string_to_num(String s) {
    char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
    int[] num = new int[s.length()];
    
    for(int i = 0; i < s.length(); i++) {
        char ch = s.charAt(i);
        for(int j = 0; j < 26; j++) {
            if(ch == alphabets[j]) {
                num[i] = j;
                break;
            }
        }
    }
    return num;
}

%>


<%!
public static int arr_to_num(int[] arr) {
    int num = 0;
    for(int i = 0; i < arr.length; i++) {
        num = num * 10 + arr[i];
    }
    return num;
}
%>


<%





Connection con=null;
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
    if(con!=null)
    {
        out.println("connection successful!");
    }

    
    String cl_id_str = request.getParameter("client_id");
    out.println(cl_id_str);

    if(cl_id_str!=null)
    {
        int cl_id = Integer.parseInt(cl_id_str);
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM bank WHERE id="+ cl_id);
%>
<html>
    <body>
        <table>
            <tr>
                <th>cust_id</th>
                <th>password</th>
                <th>ifsc_code</th>
                <th>branch_name</th>
                <th>id</th>
            </tr>
            <%
            while(rs.next()) { 
               
               String cust_id = rs.getString("c_id");
               String password = rs.getString("password");
               String ifsc_code = rs.getString("IfscCode");
               String branchName = rs.getString("branch_name");
               int id_value = rs.getInt("id");

                

               String decrypted_cust_id = decryption(cust_id, 3);
               String decrypted_password = decryption(password, 3);
               String decrypted_branchName = decryption(branchName, 3);

               int[] ifsc_num_array = string_to_num(ifsc_code); 
               int decrypted_ifsc_code = arr_to_num(ifsc_num_array);
            %>
            <tr>
                <td><%= decrypted_cust_id %></td>
                <td><%= decrypted_password %></td>
                <td><%= decrypted_ifsc_code %></td>
                <td><%= decrypted_branchName %></td>
                <td><%= id_value %></td>
            </tr>
            <% } %>
        </table>
        <%
            } else {
                out.println("id is null");
            }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </body>
</html>




