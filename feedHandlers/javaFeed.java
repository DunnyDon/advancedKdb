import java.io.BufferedReader;
import java.io.FileReader;
import java.util.List;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.Scanner;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import kx.c;
import kx.c.KException;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.format.*;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.ZoneOffset;
import java.time.Duration;
//Import libraries
public class javaFeed {

    public static void main(String[] args) throws FileNotFoundException,IOException, ParseException, KException {
	//Open kdb+ connection to TP port    
	c qConnection = new c("localhost",5000);
	//read in file
	BufferedReader reader = new BufferedReader(new FileReader("bid.csv"));
	//Set format for date that will be read in
	DateTimeFormatter formatterTest = new DateTimeFormatterBuilder().appendPattern("MM/dd/yyyy HH:mm:ss").appendPattern("[.SSSSSSSSS][.SSSSSS][.SSS]").toFormatter();
	String line = null;
	reader.readLine();
	String pattern = "MM/dd/yyyy";
	SimpleDateFormat df = new SimpleDateFormat(pattern);
	Date today = Calendar.getInstance().getTime();
	String todayAsString = df.format(today);
	LocalTime midnight2 = LocalTime.MIDNIGHT;
	LocalDate today2 = LocalDate.now(ZoneId.of("Australia/Sydney"));
	LocalDateTime todayMidnight = LocalDateTime.of(today2, midnight2);
	//Set up variables that are needed for later
	while ((line = reader.readLine()) != null){
		//Split each line via commas
		String[] values = line.split(",");
		//parse date time
		String toParse = values[0].substring(2,(values[0].length()));
		LocalDateTime tme = LocalDateTime.parse(String.join(" ",todayAsString,toParse), formatterTest);
		//Calculate ms between time read in from file and midnight and convert to ns
		long tmeMs = tme.atZone(ZoneId.of("Australia/Sydney")).toInstant().toEpochMilli();	
		long msecondsPassed = todayMidnight.atZone(ZoneId.of("Australia/Sydney")).toInstant().toEpochMilli();
	        long j=((tmeMs-msecondsPassed-5184000000L))*1000000L;
		//Use ns calculation to create kdb+ timespan
		c.Timespan kdbTime = new c.Timespan(j);
		String sym = values[1];
		Double price = Double.parseDouble(values[2]);
		Long size = Long.parseLong(values[3]);
		String exc = values[4];
		Object[] data = new Object[] {kdbTime, sym, price, size, exc};
		qConnection.ks(".u.upd", "bid", data);
		//convert the data types to the appropriate data types and send to kdb+ TP

	}
	//qConnnection.close();
    }

}
