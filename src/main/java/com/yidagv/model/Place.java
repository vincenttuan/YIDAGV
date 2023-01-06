package com.yidagv.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Place {
    
    private int id;
    private int[] coordinate; // left, top (x, y) 的資訊
    private static Map<Integer, int[]> map = new LinkedHashMap<>();
    static {
        int deltaX = 0, deltaY = 0;
        map.put(1001, new int[]{850+deltaX, 90+deltaY});
        map.put(1002, new int[]{850+deltaX, 135+deltaY});
        map.put(1003, new int[]{850+deltaX, 180+deltaY});
        map.put(1004, new int[]{690+deltaX, 180+deltaY});
        map.put(1005, new int[]{530+deltaX, 180+deltaY});
        map.put(1006, new int[]{530+deltaX, 135+deltaY});
        map.put(1007, new int[]{530+deltaX, 90+deltaY});
        map.put(1008, new int[]{260+deltaX, 60+deltaY});
        map.put(1009, new int[]{90+deltaX, 60+deltaY});
        map.put(1010, new int[]{90+deltaX, 120+deltaY});
    }
    
    public Place(int id) {
        this.id = id;
        this.coordinate = map.get(id);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int[] getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(int[] coordinate) {
        this.coordinate = coordinate;
    }

    public static Map<Integer, int[]> getMap() {
        return map;
    }

    public static void setMap(Map<Integer, int[]> map) {
        Place.map = map;
    }
    
    
    
}
