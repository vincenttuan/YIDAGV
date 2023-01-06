package com.yidagv.model;

import java.util.ArrayList;
import java.util.List;

public class AGV {

    private int status;
    private Place place;
    private String task;
    private int battery;
    private Station station;
    private List<Task> tasks = new ArrayList<>();

    // Getter Methods 
    public int getStatus() {
        return status;
    }

    public Place getPlace() {
        return place;
    }

    public String getTask() {
        return task;
    }

    public int getBattery() {
        return battery;
    }

    public Station getStation() {
        return station;
    }

    // Setter Methods 
    public void setStatus(int status) {
        this.status = status;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public void setBattery(int battery) {
        this.battery = battery;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }
    
    public void addTask(Task task) {
        this.tasks.add(task);
    }
    
    public void removeTaskById(String id) {
        for(int i=0;i<tasks.size();i++) {
            if(tasks.get(i).getId().equals(id)) {
                tasks.remove(i);
                break;
            }
        }
    }
}


