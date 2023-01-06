package com.yidagv.model;

import java.util.ArrayList;

public class AGV {

    private float status;
    private float place;
    private String task;
    private float battery;
    private Station station;
    private ArrayList<Task> tasks = new ArrayList<>();

    // Getter Methods 
    public float getStatus() {
        return status;
    }

    public float getPlace() {
        return place;
    }

    public String getTask() {
        return task;
    }

    public float getBattery() {
        return battery;
    }

    public Station getStation() {
        return station;
    }

    // Setter Methods 
    public void setStatus(float status) {
        this.status = status;
    }

    public void setPlace(float place) {
        this.place = place;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public void setBattery(float battery) {
        this.battery = battery;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    public ArrayList<Task> getTasks() {
        return tasks;
    }

    public void setTasks(ArrayList<Task> tasks) {
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


