pragma Singleton
import QtQuick

QtObject {


    function getCurrentWeek() {
        var now = new Date();
        var startDay = 1; //0=sunday, 1=monday etc.
        var d = now.getDay(); //get the current day
        var weekStart = new Date(now.valueOf() - (d <= 0 ? 7-startDay : d-startDay)*86400000); //rewind to start day
        var weekEnd = new Date(weekStart.valueOf() + 6*86400000); //add 6 days to get last
        return {weekStart, weekEnd}
    }

    function isCurrentWeek(startDate, endDate) {
        let current_week = getCurrentWeek()
        let mon = current_week.weekStart
        let sun = current_week.weekEnd

        if(mon.getDate() === new Date(startDate).getDate() && mon.getMonth() === new Date(startDate).getMonth()
                && mon.getFullYear() === new Date(startDate).getFullYear()) {
            return true
        } else {
            return false
        }
    }

    function getDaysArray(start, end) {
        for(var arr=[],dt=new Date(start); dt<=end; dt.setDate(dt.getDate()+1)){
            arr.push(new Date(dt));
        }
        return arr;
    }

    function dayToString(day) {
        return ['sun','mon','tue','wed','thu','fri','sat'][day]
    }
}
