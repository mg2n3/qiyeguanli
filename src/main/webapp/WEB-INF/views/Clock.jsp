<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>Title</title>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css"/>
    <link rel="stylesheet" href="https://www.layuicdn.com/layui/css/layui.css" media="all">
</head>
<style>
    html, body {
        height: 100%;
        text-align: center
    }

    .info {
        width: 26rem;
    }

    #container {
        height: 50%;
        width: 95%;
        margin: 0 auto;
    }

    #distance {
        margin: 10px;

        font-size: 12px;
    }

    #time {
        font-size: 16px;
        color: #1e9fff;
        font-weight: bold;
        margin: 10px;
    }

    #signbtn {
        margin: 10px auto;
        width: 140px;
        height: 140px;
        border-radius: 50%;
        box-shadow: 0px 0px 8px #25a4ff;
        font-size: 20px;
    }

    #place {
        margin: 5px auto;
        height: 20px;
        color: #ffffff;
        width: 80px;
        font-size: 12px;
        padding-top: 1px;
    }

    .isdiy {
        background-color: #5fb878;
    }

    .nodiy {
        background-color: #ff5722;
    }

    .layui-form-switch {
        width: -5%;
        height: 20%;
        background-color: #ff5722;
        margin: 5px 0;

    }

    .layui-form-onswitch {
        background-color: #009688;

    }

    .layui-form-switch em {
        color: #ffffff !important;
    }

    #box {
        position: fixed;
        bottom: 0;
        margin: 10px auto;
        width: 100%;
    }

    #history {
        text-align: left;
        margin: 10px auto;
        width: 100%;
        display: flex;
        display: -webkit-flex;
        justify-content: center;
        align-items: center;
    }

    .layui-timeline-item {
        position: relative;
        padding-bottom: 5px;
    }

    .layui-text {
        line-height: 15px;
        font-size: 14px;
        color: #666;
    }

    #weizhi {
        margin-top: -8px;
        display: block;
        color: #009f95;
        font-size: 11px;
    }

    .signtype {
        color: orange;
        font-style: normal;
    }

    #location {
        font-size: 12px;
    }
</style>
<body>
<% if (request.getAttribute("message") != null) { %>
<div id="error-message"><%= request.getAttribute("message") %></div>
<% } %>
<div id='container'></div>
<div class="info">
    <h4 id='status'></h4>
    <hr>
    <p id='result'></p>
    <hr>
</div>


<div id="box">
    <div id='time'>企业管理系统</div>
    <button id='signbtn' class="layui-btn layui-btn-normal">考勤签到</button>
    <br>
    <div id="place" type="button" class="layui-btn-radius">非办公地点</div>
    <div id='distance'>系统正在定位中</div>
    <div id='location'>系统正在定位中</div>

    <form id="add" action="${pageContext.request.contextPath}/attendance/addClock" method="post">
        <input type="hidden" id="date" name="date" value="">
        <input type="hidden" id="checkInTime" name="checkInTime" value="">
        <input type="hidden" id="checkOutTime" name="checkOutTime" value="">
        <input type="hidden" id="state" name="state" value="">
    </form>

</div>
<script>
    window.onload = function () {
    var errorMessage = document.getElementById('error-message');
    if (errorMessage) {
        alert(errorMessage.textContent);
    }
};
</script>
<input type="hidden" id="isonoff" name="isonoff" value="true">
<input type="hidden" id="userid" name="userid" value="0">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="https://www.layuicdn.com/layui/layui.js" charset="utf-8"></script>
<script src="https://cdn.bootcss.com/layer/2.3/layer.js"></script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=f63967ecf1b2a5d7603c026cf6a7b8f9"></script>
<script src="https://webapi.amap.com/maps?v=1.4.15&key=f63967ecf1b2a5d7603c026cf6a7b8f9&plugin=AMap.CircleEditor"></script>
<script src="https://a.amap.com/jsapi_demos/static/demo-center/js/demoutils.js"></script>
<script type="text/javascript">

    var map = new AMap.Map('container', {
        resizeEnable: true
    });
    //定位
    AMap.plugin('AMap.Geolocation', function () {
        var geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：5s
            buttonPosition: 'RB',    //定位按钮的停靠位置
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,   //定位成功后是否自动调整地图视野到定位点

        });
        map.addControl(geolocation);
        geolocation.getCurrentPosition(function (status, result) {
            if (status == 'complete') {
                onComplete(result)
            } else {
                onError(result)
            }
        });
    });

    //解析定位结果
    function onComplete(data) {
        // 获取当前日期
        var currentDate = new Date().toISOString().slice(0, 10); // 格式为 YYYY-MM-DD

        document.getElementById('status').innerHTML = '定位成功'
        var str = [];
        str.push('定位结果：' + data.position);
        str.push('定位类别：' + data.location_type);
        if (data.accuracy) {
            str.push('精度：' + data.accuracy + ' 米');
        }//如为IP精确定位结果则没有精度信息
        str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
        document.getElementById('result').innerHTML = str.join('<br>');

        getposition = [data.position.lng, data.position.lat];//获取当前位置的经纬度
        var location = data.formattedAddress;//具体街道位置信息
        console.log(getposition);
        //这个地方是设置打卡的位置的
        var shanghaizone = [106.592967,29.426123];//设置的签到点
        // 106.593613,29.426552
        // 104.059423,30.594589 成都
        // 106.590111, 29.422049 重庆
        //计算当前位置与考勤点距离
        var distance = AMap.GeometryUtil.distance(getposition, shanghaizone).toFixed(0);

        console.log(distance);
        //document.getElementById('distance').innerHTML = distancestr;
        var setDistance = 500;//设定的打卡距离

        document.getElementById('location').innerHTML = location;

        var distancestr = '仍距' + distance + '米';
        console.log(distance);
        if (distance <= setDistance) {
            //在范围内
            document.getElementById('distance').innerHTML = '</i><i class="layui-icon layui-icon-face-smile" style="font-size:12px; color:#17bc84;">  你已进入考勤范围  </i>  ';
            document.getElementById("place").innerHTML = "办公地点 ";
            $("#place").addClass("isdiy");

        } else {
            //不在范围内
            document.getElementById('distance').innerHTML = '<i class="layui-icon layui-icon-face-cry" style="font-size: 10px; color:red;">  未进入考勤范围 </i><a style="color:#29a6ff" onClick="window.location.reload()">重新定位 </a> ';
            document.getElementById("place").innerHTML = "非办公地点 ";
            $("#place").addClass("nodiy");
        }
        var circle = new AMap.Circle({
            center: shanghaizone,
            radius: 500, //半径
            borderWeight: 1,
            strokeOpacity: 1,
            strokeOpacity: 0.2,
            fillOpacity: 0.4,
        })
        circle.setMap(map)
        // 缩放地图到合适的视野级别
        map.setFitView([circle])
        var circleEditor = new AMap.CircleEditor(map, circle)
        var clickCount = 0;
        $("#signbtn").click(function () {
            clickCount++;
            var currentTime = new Date().toLocaleTimeString(); // 获取当前时间
            var twoTime = new Date().toLocaleTimeString(); // 获取当前时间，用于第二次打卡

            if(clickCount === 1){
                if (distance <= setDistance) {
                    layer.msg("上班打卡");
                    document.getElementById('date').value = currentDate;
                    document.getElementById('checkInTime').value = currentTime;
                } else {
                    $("#signbtn").prop('disabled', true);
                }
            }
            if(clickCount === 2){
                if (distance <= setDistance) {
                    layer.msg("下班打卡");
                    document.getElementById('checkOutTime').value = twoTime;
                    var checkInTime = document.getElementById('checkInTime').value; // 假设checkInTime是一个表单元素的值
                    var checkOutTime = document.getElementById('checkOutTime').value
                    var state = 0; // 默认status为0
                    // 检查checkInTime是否大于9点
                    if (checkInTime > '09:00:00') {
                        state = 1; // 如果大于9点，设置status为1
                    }
                    // 检查checkOutTime是否小于18点
                    if (checkOutTime < '18:00:00') {
                        state = 2; // 如果小于18点，设置status为2或3（如果已经是1）
                    }
                    // 设置表单的status值
                    document.getElementById('state').value = state;
                    document.getElementById('add').submit();
                } else {
                    $("#signbtn").prop('disabled', true);
                }
            }
            if(clickCount >= 3){
                if (distance <= setDistance) {
                    layer.msg("今天已经打过两次卡了");
                } else {
                    $("#signbtn").prop('disabled', true);
                }
            }
        });
    }

    //解析定位错误信息
    function onError(data) {
        document.getElementById('location').innerHTML = '定位失败';
        document.getElementById('location').innerHTML = '失败原因排查信息:' + data.message;
    }
</script>
<script>
    setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());", 1000);
    now = new Date(), hour = now.getHours();
    if (hour > 12) {
        $("#defshow").html(' <input id="shangxiaban" type="checkbox" name="close" lay-filter="switchTest" lay-skin="switch" lay-text="上班签到|下班签退">');
        $("#isonoff").val(false);
    }

</script>
</body>
</html>