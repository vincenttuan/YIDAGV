package com.yidagv.model;

public class Task {
    
    private String id;
    private int start_station;
    private int end_station;
    private int notice_station;

    public Task() {
    }

    public Task(String id, int start_station, int end_station, int notice_station) {
        this.id = id;
        this.start_station = start_station;
        this.end_station = end_station;
        this.notice_station = notice_station;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getStart_station() {
        return start_station;
    }

    public void setStart_station(int start_station) {
        this.start_station = start_station;
    }

    public int getEnd_station() {
        return end_station;
    }

    public void setEnd_station(int end_station) {
        this.end_station = end_station;
    }

    public int getNotice_station() {
        return notice_station;
    }

    public void setNotice_station(int notice_station) {
        this.notice_station = notice_station;
    }
    
    
}
