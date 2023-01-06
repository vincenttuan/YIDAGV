<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pure-min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/yid.css">
        
        <script>
            var ststation=0;
            var noticestation=0;
        </script>
        <script type="text/javascript">
            // 選擇日期(稼動率)
            $(function() {
            $('#datepicker').datepicker({
                format:"yyyy-mm-dd",
                defaultDate:new Date()
            });
        });
        $(function() {
            $('#datepicker1').datepicker({
                format:"yyyy-mm-dd",
                defaultDate:new Date()
            });
        });
        </script>
        <script>
            var xhr = new XMLHttpRequest();
            var baseUrl = 'http://localhost:8080${pageContext.request.contextPath}/mvc';
            
            window.onload = function(){
                setInterval(getData, 1000);
            };
            
            function getData() {
                xhr.open('GET', baseUrl + "/agv/json", true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var data = JSON.parse(this.responseText);
                        console.log(data);
                        update(data);
                    }
                };
            }
            
            function removeTaskById(id) {
                xhr.open('GET', baseUrl + "/agv/remove/task/" + id, true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var data = JSON.parse(this.responseText);
                        console.log(data);
                        update(data);
                    }
                };
            }
            
            function update(data){  // 更新資料
                // 工作狀態
                switch (data.status) {
                    case 0:
                      document.getElementById("status").value = "未連線";
                      break;
                    case 1:
                      document.getElementById("status").value = "待命中";
                      break;
                    case 2:
                      document.getElementById("status").value = "任務執行中";
                      break;
                    default:
                      console.log(`內容錯誤: ${data.status}.`);
                }
                document.getElementById("task").value = data.task;  // 目前任務
                document.getElementById("place").value = data.place.id;  // 目前位置
                document.getElementById("battery").value = data.battery+"%";  // 目前電壓
                // 放車子
                document.getElementById("agv_car").innerHTML = '<img src="${pageContext.request.contextPath}/image/car.png" width="80" ' +
                                                               'style="position: absolute;left: ' + data.place.coordinate[0] + 'px;top: ' + data.place.coordinate[1] + 'px;z-index: 10" />';
                // 佇列任務
                for(let i=0;i<data.tasks.length;i++){
                    let n = String("task"+(i));
                    document.getElementById(n).innerHTML = 
//                            "<th>"+data.task_list[n].id+"</th>"+
                            "<td>"+data.tasks[i].start_station+"</td><td>"+
                            data.tasks[i].notice_station+"</td><td>"+data.tasks[i].end_station+"</td>"+
                            "<button type=\"button\" class=\"btn btnt\" onclick=\"removeTaskById('"+data.tasks[i].id+"')\">"+
                            "<svg xmlns=\"${pageContext.request.contextPath}/image/trash.svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-trash\" viewBox=\"0 0 16 16\">"+
                            "<path d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\"/>"+
                            "<path fill-rule=\"evenodd\" d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\"/>"+
                            "</svg></button>";
                }
                // 更改站點按鈕顏色
                for(var i=1;i<4;i++){
                    for(var j=1;j<6;j++){
                        let n = "s" + String(i)+String(j);
                        let m = String(i)+"-"+String(j);
                        switch (data.station[n]) {
                            case 0:
                              document.getElementById(m).className = "st btn btn-success disabled";
                              break;
                            case 1:
                              document.getElementById(m).className = "st btn btn-danger disabled";
                              break;
                            case 2:
                              document.getElementById(m).className = "st btn btn-primary";
                              break;
                            case 3:
                              document.getElementById(m).className = "st btn btn-warning disabled";
                              break;
                            default:
                              console.log(`內容錯誤: ${data.station[n]}.`);
                        }
                    }
                }
                
            }
            // 監聽按鈕(實作將選擇的按鈕放入確認列)
            const cbtns = document.querySelectorAll(".st");
            const cbtns1 = document.querySelectorAll(".st1");
            
            function doit() {
                document.getElementById("ststation").value = this.id;
            }
            
            function doit1() {
                document.getElementById("noticestation").value = this.id;
            }
            
            cbtns.forEach(
              function(cbtn) {
               cbtn.addEventListener("click", doit,false);
              }
            );
            
            cbtns1.forEach(
              function(cbtn1) {
               cbtn1.addEventListener("click", doit1,false);
              }
            );
            // 紀錄確認列與發送
            function subm(){alert("http://192.168.1.246:20100/task0=1&1&"+ststation+"&"+noticestation+"&"+ststation);console.log(ststation);};
            // 清除按鈕
            function cn(){
                document.getElementById("ststation").value = "";
                document.getElementById("noticestation").value = "";
            }
            
        </script>
        
        
    </head>
    <body background="${pageContext.request.contextPath}/image/bgimg.jpg" style="padding: 20px;line-height: 10px;">
        <img src="${pageContext.request.contextPath}/image/logo.png" alt="image error">
        <br>
        <span id="agv_car"></span>
        <div class="container">
            <div class="row">
                
                <img src="${pageContext.request.contextPath}/image/map.jpg" class="img-fluid" alt="image error">
            </div>
            <br>
            <div class="row justify-content-around">
                <div class="col-auto card" style=" text-align: center;font-size: 10px">
                    <fieldset>
                        <legend style=" padding: 5px;font-size: 18px;">AGV 狀態</legend>
                        <p>工作狀態：<input type="text" id="status" readonly style="text-align: center"/></p>
                        <p>目前任務：<input type="text" id="task" readonly style="text-align: center"/></p>
                        <p>即時位置：<input type="text" id="place" readonly style="text-align: center"/></p>
                        <p>目前電壓：<input type="text" id="battery" readonly style="text-align: center"/></p>
                    </fieldset>
                </div>
                <div class="col card" style=" text-align: center">
                    <fieldset>
                        <legend style=" padding: 5px;font-size: 18px;">任務佇列</legend>
                        <div style="height: 150px;overflow: auto;">
                            <table class="table table-hover" style=" font-size: 10px">
                                <thead>
                                    <tr>
                                        <th><nobr>出發站</nobr></th>
                                        <th><nobr>通知站</nobr></th>
                                        <th><nobr>終點站</nobr></th>
                                        <th><nobr></nobr></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="task" id="task0"></tr>
                                    <tr class="task" id="task1"></tr>
                                    <tr class="task" id="task2"></tr>
                                    <tr class="task" id="task3"></tr>
                                    <tr class="task" id="task4"></tr>
                                    <tr class="task" id="task5"></tr>
                                    <tr class="task" id="task6"></tr>
                                    <tr class="task" id="task7"></tr>
                                    <tr class="task" id="task8"></tr>
                                    <tr class="task" id="task9"></tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div class="col-6 card" style=" text-align: center">
                    <fieldset>
                        <legend style=" padding: 5px;font-size: 18px;">效益分析</legend>
                        
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th>總工作時數</th>
                                    <th>總開機時數</th>
                                    <th>稼動率</th>
                                    <th>累積任務數</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style=" font-size: 25px">
                                    <td><p><input class="parse" type="text" value="359" readonly/></p></td>
                                    <td><p><input class="parse" type="text" value="370" readonly/></p></td>
                                    <td><p><input class="parse" type="text" value="97%" readonly/></p></td>
                                    <td><p><input class="parse" type="text" value="138" readonly/></p></td>
                                </tr>
                            </tbody>
                        </table>
                        <!--
                        <p style=" font-size: 10px;">起算日期:</p>
                            <div class="input-group date" id="datepicker">
                            <input type="text" class="form-control" style=" width: 80px;">
                            <span class="input-group-append">
                                <span class="input-group-text bg-white">
                                </span>
                            </span>
                            </div>
                        
                        <p style=" font-size: 10px;">結算日期:</p>
                            <div class="input-group date" id="datepicker1">
                            <input type="text" class="form-control" style=" width: 80px;">
                            <span class="input-group-append">
                                <span class="input-group-text bg-white">
                                </span>
                            </span>
                            </div>
                        -->
                    </fieldset>
                </div>
            </div>
        <br>
        <div class="alert alert-danger hidden" role="alert">
            系統訊息:
        </div>
            <form>
                <div class="row justify-content-around">
                    <div class="col card" style=" align-items: center;background-color: #DEDEDE;text-align: center;">
                        <fieldset>
                            <legend style=" padding: 5px;font-size: 18px;">出發站</legend>
                            <table class="table row table-borderless">
                                <tr>
                                    <td><button type="button" class="st btn" id="1-1" onclick="ststation=1011"><nobr>1-1</nobr></button></td>
                                    <td><button type="button" class="st btn" id="1-2" onclick="ststation=1012"><nobr>1-2</nobr></button></td>
                                    <td><button type="button" class="st btn" id="1-3" onclick="ststation=1013"><nobr>1-3</nobr></button></td>
                                    <td><button type="button" class="st btn" id="1-4" onclick="ststation=1014"><nobr>1-4</nobr></button></td>
                                    <td><button type="button" class="st btn" id="1-5" onclick="ststation=1015"><nobr>1-5</nobr></button></td>
                                </tr>
                                <tr>
                                    <td><button type="button" class="st btn" id="2-1" onclick="ststation=1021"><nobr>2-1</nobr></button></td>
                                    <td><button type="button" class="st btn" id="2-2" onclick="ststation=1022"><nobr>2-2</nobr></button></td>
                                    <td><button type="button" class="st btn" id="2-3" onclick="ststation=1023"><nobr>2-3</nobr></button></td>
                                    <td><button type="button" class="st btn" id="2-4" onclick="ststation=1024"><nobr>2-4</nobr></button></td>
                                    <td><button type="button" class="st btn" id="2-5" onclick="ststation=1025"><nobr>2-5</nobr></button></td>
                                </tr>
                                <tr>
                                    <td><button type="button" class="st btn" id="3-1" onclick="ststation=1031"><nobr>3-1</nobr></button></td>
                                    <td><button type="button" class="st btn" id="3-2" onclick="ststation=1032"><nobr>3-2</nobr></button></td>
                                    <td><button type="button" class="st btn" id="3-3" onclick="ststation=1033"><nobr>3-3</nobr></button></td>
                                    <td><button type="button" class="st btn" id="3-4" onclick="ststation=1034"><nobr>3-4</nobr></button></td>
                                    <td><button type="button" class="st btn" id="3-5" onclick="ststation=1035"><nobr>3-5</nobr></button></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    
                    <div class="col card" style=" align-items: center;background-color: #DEDEDE;text-align: center;">
                        <fieldset>
                            <legend style=" padding: 5px;font-size: 18px;">通知站</legend>
                            <table class="table row table-borderless">
                                <tr>
                                    <td><button type="button" class="st1 btn btn-info" id="PCB測試" onclick="noticestation=1511"><nobr>PCB測試</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="PCB外線" onclick="noticestation=1512"><nobr>PCB外線</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="PCB外AOI" onclick="noticestation=1513"><nobr>PCB外AOI</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="PCB網印" onclick="noticestation=1514"><nobr>PCB網印</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="CNC二廠" onclick="noticestation=1515"><nobr>CNC二廠</nobr></button></td>
                                </tr>
                                <tr>
                                    <td><button type="button" class="st1 btn btn-info" id="FQC" onclick="noticestation=1521"><nobr>FQC</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="BGA整面C" onclick="noticestation=1522"><nobr>BGA整面C</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="棕化" onclick="noticestation=1523"><nobr>棕化</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="內層線路" onclick="noticestation=1524"><nobr>內層線路</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="Suep" onclick="noticestation=1525"><nobr>Suep</nobr></button></td>
                                </tr>
                                <tr>
                                    <td><button type="button" class="st1 btn btn-info" id="FVI" onclick="noticestation=1531"><nobr>FVI</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="PCB噴塗" onclick="noticestation=1532"><nobr>PCB噴塗</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="BGA整面A" onclick="noticestation=1533"><nobr>BGA整面A</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="CNC一廠" onclick="noticestation=1534"><nobr>CNC一廠</nobr></button></td>
                                    <td><button type="button" class="st1 btn btn-info" id="Routing" onclick="noticestation=1535"><nobr>Routing</nobr></button></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
                <div class="row card" style=" align-items: center;background-color: #DEDEDE;border: 20px;">
                    <br>
                    <p>出發站：<input id="ststation" type="text" readonly style="text-align: center"/>
                    通知站：<input id="noticestation" type="text" readonly style="text-align: center"/>
                    <input type="button" class="btn btn-primary" value="確認" onclick="subm()">
                    <input type="button" class="btn btn-primary" value="清除" onclick="cn()"></p>
                    
                </div>
            </form>
            <br>
            <div class="row">
                <div class="col-12" style="padding: 8px;background-color: pink;height: 30px;">
                    <marquee><p id="message"><nobr>系統訊息:無錯誤</nobr></p></marquee>
                </div>
            </div>
        <br>
    </body>
</html>

