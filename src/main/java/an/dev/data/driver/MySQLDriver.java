package an.dev.data.driver;

import java.sql.Connection;
import java.sql.DriverManager;
import static an.dev.util.Constants.*;

public class MySQLDriver {
   private static MySQLDriver instance;
   private MySQLDriver() {
	   
   }
   public static MySQLDriver getInstance() {
	   if(instance == null) instance = new MySQLDriver();
	   return instance;
   }
	public Connection getConnection() {
	    Connection conn = null;
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection(DB_URL, USER, PASS);
	        System.out.println("Kết nối mysql thành công!");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return conn; 
	}
}
