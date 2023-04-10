module ApplicationHelper
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
end
