# frozen_string_literal: true

# 倒れたピンの本数をカウント
pin = ARGV[0] # コマンドライン引数の取得
scores = pin.split(',') # 取得した値をカンマ(,)で文字列を分割して結果を配列に格納
shots = [] # 空の変数shotsを作成、取得された値が代入される
scores.each do |score| # 変数sccoreの値がXの場合はshotsに［10，0］が代入され、それ以外は数値へ変換され、代入される
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

# フレーム毎に分割
# 空の変数framesを作成、取得された値が代入される
frames = []
lane = []
shots.each do |shot|
  if frames.length > 9 # 10フレーム用の処理。10フレームを迎えていたら最後のframeにshotを追加する。
    frames.last << shot
  elsif lane.count == 1 # 2投目用の処理。frameの要素が1つだったら2投目を追加。
    lane << shot
    frames << lane
    lane = []
  else
    lane << shot
  end
end

# スコア計算
point = 0
frames.each_with_index do |frame, i| # 変数frameは配列の要素、変数iは配列の要素の順序（インデックス）
  point += if i < 8 && frames[i][0] == 10 && frames[i + 1][0] == 10 # 連続ストライクの場合
             20 + frames[i + 2][0]

           elsif i == 8 && frames[i][0] == 10 && frames[i + 1][0] == 10 # 9レーン目の次もストライク
             10 + frames[i + 1][0] + frames[i + 1][2]

           elsif i == 8 && frames[i][0] == 10 # 9レーン目の処理
             10 + frames[i + 1][0] + frames[i + 1][1]

           elsif i < 9 && frames[i][0] == 10 # ストライクの場合
             10 + frames[i + 1][0] + frames[i + 1][1] # 10 + 次のフレームの1投目 + 次のフレームの2投目

           elsif i < 9 && frame.sum == 10 && frames[0] != 10 # スペアの場合
             10 + frames[i + 1][0] # 次のフレームの1投目

           else
             frame.sum # その他の場合はフレーム内を足す
           end
end

p frames
puts point
