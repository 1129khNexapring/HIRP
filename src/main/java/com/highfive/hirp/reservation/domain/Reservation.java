package com.highfive.hirp.reservation.domain;

public class Reservation {
	private int reservationNo;
	private String emplId;
	private int utilityNo;
	private String reservationStartDate;
	private String reservationEndDate;
	private String reservationConts;
	private String isReturn;
	private Utility utility;
	private String emplName;
	private String deptName;
	private String positionName;

	public Reservation() {
	}

	public Reservation(int reservationNo, String emplId, int utilityNo, String reservationStartDate,
			String reservationEndDate, String reservationConts, String isReturn, Utility utility, String emplName,
			String deptName, String positionName) {
		super();
		this.reservationNo = reservationNo;
		this.emplId = emplId;
		this.utilityNo = utilityNo;
		this.reservationStartDate = reservationStartDate;
		this.reservationEndDate = reservationEndDate;
		this.reservationConts = reservationConts;
		this.isReturn = isReturn;
		this.utility = utility;
		this.emplName = emplName;
		this.deptName = deptName;
		this.positionName = positionName;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public String getEmplId() {
		return emplId;
	}

	public void setEmplId(String emplId) {
		this.emplId = emplId;
	}

	public int getUtilityNo() {
		return utilityNo;
	}

	public void setUtilityNo(int utilityNo) {
		this.utilityNo = utilityNo;
	}

	public String getReservationStartDate() {
		return reservationStartDate;
	}

	public void setReservationStartDate(String reservationStartDate) {
		this.reservationStartDate = reservationStartDate;
	}

	public String getReservationEndDate() {
		return reservationEndDate;
	}

	public void setReservationEndDate(String reservationEndDate) {
		this.reservationEndDate = reservationEndDate;
	}

	public String getReservationConts() {
		return reservationConts;
	}

	public void setReservationConts(String reservationConts) {
		this.reservationConts = reservationConts;
	}

	public String getIsReturn() {
		return isReturn;
	}

	public void setIsReturn(String isReturn) {
		this.isReturn = isReturn;
	}

	public Utility getUtility() {
		return utility;
	}

	public void setUtility(Utility utility) {
		this.utility = utility;
	}

	public String getEmplName() {
		return emplName;
	}

	public void setEmplName(String emplName) {
		this.emplName = emplName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	@Override
	public String toString() {
		return "Reservation [reservationNo=" + reservationNo + ", emplId=" + emplId + ", utilityNo=" + utilityNo
				+ ", reservationStartDate=" + reservationStartDate + ", reservationEndDate=" + reservationEndDate
				+ ", reservationConts=" + reservationConts + ", isReturn=" + isReturn + ", utility=" + utility
				+ ", emplName=" + emplName + ", deptName=" + deptName + ", positionName=" + positionName + "]";
	}
}
