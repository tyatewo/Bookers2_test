<div>
  <canvas id="myChart"></canvas>
</div>
<script>
  $(document).on('turbolinks:load',function(){ //turbolinkの無効化
    const ctx = document.getElementById("myChart"); //canvasで指定したidを取得し ctxに代入
      new Chart(ctx, {
      type: 'line',  //グラフの種類を表す。今回は折れ線なのでline
      data: {
        labels: ["6日前", "5日前", "4日前", "3日前", "2日前", "1日前", "今日"],　//横軸のラベル、今回は日付なのでこのように指定
         datasets: [{
           label: "投稿した本の数", //　凡例
           data: [<%= books.created_day(6).count %>,  //6日前の投稿数
           <%= books.created_day(5).count %>,  //5日前の投稿数
           <%= books.created_day(4).count %>,  //4日前の投稿数
           <%= books.created_day(3).count %>,  //3日前の投稿数
           <%= books.created_day(2).count %>,  //2日前の投稿数
           <%= books.created_day(1).count %>,  //昨日の投稿数
           <%= books.created_day(0).count %>], //今日の投稿数
          borderColor: "rgba(0,0,255,1)",  //線の色、他にもbackgroundcolor等も指定できます
          lineTension: 0.5  //折れ線の丸み具合。0で直線になります
         }],
      },
      options: {
        responsive: true,
        scales: {
          y: { //縦軸のオプション
            suggestedMin: 0,  //最小値に設定
            suggestedMax: 10, //最大値の設定
            ticks: {
              stepSize: 1,　//目盛りの数え方。今回は１刻みなため１を指定
            }
          }
        }
      }
    });
  });
</script>
