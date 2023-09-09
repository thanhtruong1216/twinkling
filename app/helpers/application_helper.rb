module ApplicationHelper
  def distance_time_from(from_time)
    to_time             = Time.current
    distance_in_minutes = ((to_time - from_time) / 60.0).floor
    distance_in_hours   = distance_in_minutes / 60
    distance_in_days    = distance_in_hours / 24

    if distance_in_days.positive?
      I18n.t('post.date_time.x_days', count: distance_in_days)
    elsif distance_in_hours.positive?
      I18n.t('post.date_time.x_hours', count: distance_in_hours)
    else
      distance_in_minutes = 1 if distance_in_minutes.zero?
      I18n.t('post.date_time.x_minutes', count: distance_in_minutes)
    end
  end

  def zodiac(birthday)
    birthdate_splited = birthday.split('/')
    birthdate_result = "#{birthdate_splited[0]}/#{birthdate_splited[1]}/#{birthdate_splited[1] == '01' ? '0001' : '0000'}".to_date

    if ("22/12/0000".to_date.."19/01/0001".to_date).cover?(birthdate_result)
      'Ma Kết'
    elsif ("20/01/0000".to_date.."18/02/0000".to_date).cover?(birthdate_result)
      'Bảo Bình'
    elsif ("19/02/0000".to_date.."20/03/0000".to_date).cover?(birthdate_result)
      'Song Ngư'
    elsif ("21/03/0000".to_date.."20/04/0000".to_date).cover?(birthdate_result)
      "Bạch Dương"
    elsif ("21/04/0000".to_date.."20/05/0000".to_date).cover?(birthdate_result)
      'Kim Ngưu'
    elsif ("21/05/0000".to_date.."21/06/0000".to_date).cover?(birthdate_result)
      'Song Tử'
    elsif ("22/06/0000".to_date.."22/07/0000".to_date).cover?(birthdate_result)
      'Cự Giải'
    elsif ("23/07/0000".to_date.."22/08/0000".to_date).cover?(birthdate_result)
      'Sư Tử'
    elsif ("23/08/0000".to_date.."22/09/0000".to_date).cover?(birthdate_result)
      'Xử Nữ'
    elsif ("23/09/0000".to_date.."22/10/0000".to_date).cover?(birthdate_result)
      'Thiên Bình'
    elsif ("24/10/0000".to_date.."22/11/0000".to_date).cover?(birthdate_result)
      'Bọ Cạp'
    elsif ("22/11/0000".to_date.."21/12/0000".to_date).cover?(birthdate_result)
      'Nhân Mã'
    end
  end

  def destiny(year)
    case year.to_i
    when 1983
      'Đại Hải Thủy - Nước biển lớn'
    when 1984
      'Hải Trung Kim - Vàng trong biển'
    when 1985
      'Hải Trung Kim - Vàng trong biển'
    when 1986
      'Lư Trung Hỏa - Lửa trong lò'
    when 1987
      'Lư Trung Hỏa - Lửa trong lò'
    when 1988
      'Đại Lâm Mộc - Gỗ rừng già'
    when 1989
      'Đại Lâm Mộc - Gỗ rừng già'
    when 1990
      'Lộ Bàng Thổ - Đất đường đi'
    when 1991
      'Lộ Bàng Thổ - Đất đường đi'
    when 1992
      'Kiếm Phong Kim - Vàng mũi kiếm'
    when 1993
      'Kiếm Phong Kim - Vàng mũi kiếm'
    when 1994
      'Sơn Đầu Hỏa - Lửa trên núi'
    when 1995
      'Sơn Đầu Hỏa - Lửa trên núi'
    when 1996
      'Giản Hạ Thủy - Nước khe suối'
    when 1997
      'Giản Hạ Thủy - Nước khe suối'
    when 1998
      'Thành Đầu Thổ - Đất trên thành'
    when 1999
      'Thành Đầu Thổ - Đất trên thành'
    when 2000
      'Bạch Lạp Kim - Vàng sáp ong'
    else
    end
  end

  def chinese_zodiac(year)
    case year.to_i
    when 1983
      'Quý Hợi'
    when 1984
      'Giáp Tý'
    when 1985
      'Ất Sửu'
    when 1986
      'Bính Dần'
    when 1987
      'Đinh Mão'
    when 1988
      'Mậu Thìn'
    when 1989
      'Kỷ Tỵ'
    when 1990
      'Canh Ngọ'
    when 1991
      'Tân Mùi'
    when 1992
      'Nhâm Thân'
    when 1993
      'Quý Dậu'
    when 1994
     'Giáp Tuất'
    when 1995
      'Ất Hợi'
    when 1996
      'Bính Tý'
    when 1997
      'Đinh Sửu'
    when 1998
      'Mậu Dần'
    when 1999
      'Kỷ Mão'
    when 2000
      'Canh Thìn'
    else
    end
  end

  def zodiac_name_translate(zodiac_name)
    case zodiac_name
    when 'Quý Hợi'
      'Lâm Hạ Chi Trư - Lợn trong rừng'
    when 'Giáp Tý'
      'Ốc Thượng Chi Thử - Chuột ở nóc nhà'
    when 'Ất Sửu'
      'Hải Nội Chi Ngưu - Trâu trong biển'
    when 'Bính Dần'
      'Sơn Lâm Chi Hổ - Hổ trong rừng'
    when 'Đinh Mão'
      'Vọng Nguyệt Chi Thố - Thỏ ngắm trăng'
    when 'Mậu Thìn'
      'Thanh Ôn Chi Long - Rồng ôn hoà'
    when 'Kỷ Tỵ'
      'Phúc Khí Chi Xà - Rắn có phúc'
    when 'Canh Ngọ'
      'Thất Lý Chi Mã - Ngựa trong nhà'
    when 'Tân Mùi'
      'Đắc Lộc Chi Dương - Dê có lộc'
    when 'Nhâm Thân'
      'Thanh Tú Chi Hầu - Khỉ thanh tú'
    when 'Quý Dậu'
      'Lâu Túc Kê - Gà nhà gác'
    when 'Giáp Tuất'
     'Thủ Thân Chi Cẩu - Chó giữ mình'
    when 'Ất Hợi'
      'Quá Vãng Chi Trư - Lợn hay đi'
    when 'Bính Tý'
      'Điền Nội Chi Thử - Chuột trong ruộng'
    when 'Đinh Sửu'
      'Hồ Nội Chi Ngưu - Trâu trong hồ nước'
    when 'Mậu Dần'
      'Quá Sơn Chi Hổ - Hổ qua rừng'
    when 'Kỷ Mão'
      'Sơn Lâm Chi Thố - Thỏ ở rừng'
    when 'Canh Thìn'
      'Thứ Tính Chi Long - Rồng khoan dung'
    else
    end
  end

  def zodiac_name_translate_male(year)
    case year.to_i
    when 1983
      'Cấn Thổ'
    when 1984
      'Đoài Kim'
    when 1985
      'Càn Kim'
    when 1986
      'Khôn Thổ'
    when 1987
      'Tốn Mộc'
    when 1988
      'Chấn Mộc'
    when 1989
      'Khôn Thổ'
    when 1990
      'Khảm Thuỷ'
    when 1991
      'Ly Hoả'
    when 1992
      'Cấn Thổ'
    when 1993
      'Đoài Kim'
    when 1994
     'Càn Kim	'
    when 1995
      'Khôn Thổ'
    when 1996
      'Tốn Mộc'
    when 1997
      'Chấn Mộc'
    when 1998
      'Khôn Thổ'
    when 1999
      'Khảm Thuỷ'
    when 2000
      'Ly Hoả'
    else
    end
  end

  def zodiac_name_translate_female(year)
    case year.to_i
    when 1983
      'Đoài Kim'
    when 1984
      'Cấn Thổ'
    when 1985
      'Ly Hoả'
    when 1986
      'Khảm Thuỷ'
    when 1987
      'Khôn Thổ'
    when 1988
      'Chấn Mộc'
    when 1989
      'Tốn Mộc'
    when 1990
      'Cấn Thổ'
    when 1991
      'Càn Kim'
    when 1992
      'Đoài Kim'
    when 1993
      'Cấn Thổ'
    when 1994
     'Ly Hoả'
    when 1995
      'Khảm Thuỷ'
    when 1996
      'Khôn Thổ'
    when 1997
      'Chấn Mộc'
    when 1998
      'Tốn Mộc'
    when 1999
      'Cấn Thổ'
    when 2000
      'Càn Kim'
    else
    end
  end
  
  def west_zodiacs_suit(sign)
    result = {}
  
    case sign

    when 'Ma Kết'
      result = {
        suit: 'Kim Ngưu',
        avoid: 'Bạch Dương'
      }
    when 'Bảo Bình'
      result = {
        suit: 'Song Tử',
        avoid: 'Bọ Cạp'
      }
    when 'Song Ngư'
      result = {
        suit: 'Cự Giải, Bọ Cạp',
        avoid: 'Bảo Bình'
      }
    when 'Bạch Dương'
      result = {
        suit: 'Cự Giải, Ma Kết',
        avoid: 'Xử Nữ'
      }
    when 'Kim Ngưu'
      result = {
        suit: 'Cự Giải',
        avoid: 'Song Tử'
      }
    when 'Song Tử'
      result = {
        suit: 'Bảo Bình, Thiên Bình',
        avoid: 'Xử Nữ'
      }
    when 'Cự Giải'
      result = {
        suit: 'Song Ngư',
        avoid: 'Ma Kết'
      }
    when 'Sư Tử'
      result = {
        suit: 'Nhân Mã',
        avoid: 'Thiên Bình'
      }
    when 'Xử Nữ'
      result = {
        suit: 'Kim Ngưu',
        avoid: 'Nhân Mã'
      }
    when 'Thiên Bình'
      result = {
        suit: 'Song Tử',
        avoid: 'Song Ngư'
      }
    when 'Bọ Cạp'
      result = {
        suit: 'Cự Giải, Song Ngư',
        avoid: 'Sư Tử'
      }
    when 'Nhân Mã'
      result = {
        suit: 'Sư Tử, Bạch Dương',
        avoid: 'Kim Ngưu'
      }
    else
    end
    result
  end

  def chinese_zodiac_analysis(name)
    result = {}

    case name.split(' ')[1]

    when 'Tý'
      result = {
        suit: 'Thân, Thìn',
        avoid: 'Ngọ'
      }
    when 'Sửu'
      result = {
        suit: 'Tỵ, Dậu',
        avoid: 'Mùi'
      }
    when 'Dần'
      result = {
        suit: 'Ngọ, Tuất',
        avoid: 'Thân'
      }
    when 'Mẹo'
      result = {
        suit: 'Hợi, Mùi',
        avoid: 'Dậu'
      }
    when 'Thìn'
      result = {
        suit: 'Thân, Tý',
        avoid: 'Tuất'
      }
    when 'Tỵ'
      result = {
        suilt: 'Dậu, Sửu',
        avoid: 'Hợi'
      }
    when 'Ngọ'
      result = {
        suit: 'Dần, Tuất',
        avoidd: 'Tý'
      }
    when 'Mùi'
      result = {
        suit: 'Hợi, Mẹo',
        avoid: 'Sửu'
      }
    when 'Thân'
      result = {
        suit: 'Tý, Thìn',
        avoid: 'Dần'
      }
    when 'Dậu'
      result = {
        suit: 'Tỵ, Sửu',
        avoid: 'Mẹo'
      }
    when 'Tuất'
      result = {
        suit: 'Dần, Ngọ',
        avoid: 'Thìn'
      }
    when 'Hợi'
      result = {
        suit: 'Mẹo, Mùi',
        avoid: 'Tỵ'
      }
    else
    end
    result
  end

  def five_elements_analysis(element)
    result = {}

    case element.split('-')[0].split(' ')[2]
    when 'Kim'
      result = {
        suit: 'Thủy, Thổ',
        avoid: 'Hỏa, Mộc'
      }
    when 'Mộc'
      result = {
        suit: 'Hỏa, Thủy',
        avoid: 'Thổ, Kim'
      }
    when 'Thủy'
      result = {
        suit: 'Mộc, Kim',
        avoid: 'Thổ, Hỏa'
      }
    when 'Hỏa'
      result = {
        suit: 'Thổ, Mộc',
        avoid: 'Thủy, Kim'
      }
    when 'Thổ'
      result = {
        suit: 'Kim, Hỏa',
        avoid: 'Mộc, Thủy'
      }
    else
    end
    result
  end

  def trigrams_analysis(element)
    result = {}

    case element.split(' ')[0]
    when 'Cấn'
      result = {
        suit: 'Cấn, Càn, Khôn, Đoài',
        avoid: 'Khảm, Chấn, Tốn, Ly'
      }
    when 'Ly'
      result = {
        suit: 'Ly, Tốn, Đoài, Khôn',
        avoid: 'Càn, Khảm, Cấn'
      }
    when 'Đoài'
      result = {
        suit: 'Đoài, Càn, Cấn, Khôn',
        avoid: 'Khảm, Chấn, Tốn, Ly'
      }
    when 'Khôn'
      result = {
        suit: 'Khôn, Cấn, Càn, Đoài',
        avoid: 'Khảm, Chấn, Tốn, Ly'
      }
    when 'Khảm'
      result = {
        suit: 'Khảm, Chấn, Ly, Tốn',
        avoid: 'Cấn, Khôn, Chấn, Đoài'
      }
    when 'Chấn'
      result = {
        suit: 'Chấn, Khảm, Tốn, Ly',
        avoid: 'Càn, Cấn, Khôn, Đoài'
      }
    when 'Tốn'
      result = {
        suit: 'Tốn, Khảm, Ly, Chấn',
        avoid: 'Càn, Đoài, Khôn, Cấn'
      }
    when 'Càn'
      result = {
        suit: 'Càn, Cấn, Khôn, Đoài',
        avoid: 'Khảm, Chân, Tốn, Ly'
      }
    else
    end
    result
  end
end
