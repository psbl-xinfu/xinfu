package com.ccms.api.customer;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 赵亚斌
 * @date 2019年4月23日
 * 
 */
public class PrepareBean implements Serializable{
	private String ReservationID;
	private String ReservationTime;
	private String ReservationStatus;
	private String EmployeeName;
	private String MemberID;
	private String MemberName;
	private String MemberMobile;
	private String LessonName;
	private String StillNumber;
	private String ReservationNumber;
	private String LessonStartTime;
	private String LessonEndTime;
	public String getReservationID() {
		return ReservationID;
	}
	public void setReservationID(String reservationID) {
		ReservationID = reservationID;
	}
	public String getReservationTime() {
		return ReservationTime;
	}
	public void setReservationTime(String reservationTime) {
		ReservationTime = reservationTime;
	}
	public String getReservationStatus() {
		return ReservationStatus;
	}
	public void setReservationStatus(String reservationStatus) {
		ReservationStatus = reservationStatus;
	}
	public String getEmployeeName() {
		return EmployeeName;
	}
	public void setEmployeeName(String employeeName) {
		EmployeeName = employeeName;
	}
	public String getMemberID() {
		return MemberID;
	}
	public void setMemberID(String memberID) {
		MemberID = memberID;
	}
	public String getMemberName() {
		return MemberName;
	}
	public void setMemberName(String memberName) {
		MemberName = memberName;
	}
	public String getMemberMobile() {
		return MemberMobile;
	}
	public void setMemberMobile(String memberMobile) {
		MemberMobile = memberMobile;
	}
	public String getLessonName() {
		return LessonName;
	}
	public void setLessonName(String lessonName) {
		LessonName = lessonName;
	}
	public String getStillNumber() {
		return StillNumber;
	}
	public void setStillNumber(String stillNumber) {
		StillNumber = stillNumber;
	}
	public String getReservationNumber() {
		return ReservationNumber;
	}
	public void setReservationNumber(String reservationNumber) {
		ReservationNumber = reservationNumber;
	}
	public String getLessonStartTime() {
		return LessonStartTime;
	}
	public void setLessonStartTime(String lessonStartTime) {
		LessonStartTime = lessonStartTime;
	}
	public String getLessonEndTime() {
		return LessonEndTime;
	}
	public void setLessonEndTime(String lessonEndTime) {
		LessonEndTime = lessonEndTime;
	}
	
	
	
}
