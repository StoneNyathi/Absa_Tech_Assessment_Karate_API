package karatepoc.bolt;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTime {

    private String toFullDateFormat = "dd-MM-yyyy";
    private String timeStampFormat = "yyyyMMddHHmmss";
    private String formatedTimeStampFormat = "yyyy_MM_dd_HHmmss";
    private String toDateFormat = "yyyyMMdd";


    public String getBusinessRefNumber(String arg) {
        String displayTime = "";
        try {
            displayTime = (new SimpleDateFormat(timeStampFormat).format(new Date()));
        } catch (Exception e) {
            System.out.println("Date Time Seems To Be Incorrect. : " + e.getMessage());
        }
        return "0000"+displayTime;
    }

    public String getFullDate(String arg) {
        String displayTime = "";
        try {
            displayTime = (new SimpleDateFormat(toFullDateFormat).format(new Date()));
        } catch (Exception e) {
            System.out.println("Date Time Seems To Be Incorrect. : " + e.getMessage());
        }
        return displayTime;
    }

    public String getDate(String arg) {
        String displayTime = "";
        try {
            displayTime = (new SimpleDateFormat(toDateFormat).format(new Date()));
        } catch (Exception e) {
            System.out.println("Date Time Seems To Be Incorrect. : " + e.getMessage());
        }
        return displayTime;
    }

    public String getTimeStamp(String arg) {
        String displayTime = "";
        try {
            displayTime = (new SimpleDateFormat(timeStampFormat).format(new Date()));
        } catch (Exception e) {
            System.out.println("Date Time Seems To Be Incorrect. : " + e.getMessage());
        }
        return displayTime;
    }

    public String getFormatedTimeStamp(String arg) {
        String displayTime = "";
        try {
            displayTime = (new SimpleDateFormat(formatedTimeStampFormat).format(new Date()));
        } catch (Exception e) {
            System.out.println("Date Time Seems To Be Incorrect. : " + e.getMessage());
        }
        return displayTime;
    }

    public String getConvertedDateStamp(String arg) {
        String convertedDate = "";
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
//        cal.setTime( dateFormat.parse(untildate));
            cal.add(Calendar.DATE, 1);
            convertedDate = dateFormat.format(cal.getTime());
            System.out.println("Date increase by one.." + convertedDate);
        } catch (Exception e) {
            System.out.println("Date Time Seems to be Incorrect. : " + e.getMessage());
        }
        return convertedDate;
    }

    public String getFirstPaymentDAte(String arg) {
        String convertedDate = "";
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            Calendar cal = Calendar.getInstance();
//        cal.setTime( dateFormat.parse(untildate));
            cal.add(Calendar.DATE, 30);
            convertedDate = dateFormat.format(cal.getTime());
            System.out.println("Date increase by one.." + convertedDate);
        } catch (Exception e) {
            System.out.println("Date Time Seems to be Incorrect. : " + e.getMessage());
        }
        return convertedDate;
    }

    public String getContractStartDate(String arg) {
        String convertedDate = "";
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            Calendar cal = Calendar.getInstance();
//        cal.setTime( dateFormat.parse(untildate));
            cal.add(Calendar.DATE, 5);
            convertedDate = dateFormat.format(cal.getTime());
            System.out.println("Date increase by one.." + convertedDate);
        } catch (Exception e) {
            System.out.println("Date Time Seems to be Incorrect. : " + e.getMessage());
        }
        return convertedDate;
    }
}
