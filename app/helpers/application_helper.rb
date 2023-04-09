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
      'Đại Hải Thủy (Nước biển lớn)'
    when 1984
      'Hải Trung Kim (Vàng trong biển)'
    when 1985
      'Hải Trung Kim (Vàng trong biển)'
    when 1986
      'Lư Trung Hỏa(Lửa trong lò)'
    when 1987
      'Lư Trung Hỏa(Lửa trong lò)'
    when 1988
      'Đại Lâm Mộc (Gỗ rừng già)'
    when 1989
      'Đại Lâm Mộc (Gỗ rừng già)'
    when 1990
      'Lộ Bàng Thổ (Đất đường đi)'
    when 1991
      'Lộ Bàng Thổ (Đất đường đi)'
    when 1992
      'Kiếm Phong Kim (Vàng mũi kiếm)'
    when 1993
      'Kiếm Phong Kim (Vàng mũi kiếm)'
    when 1994
     'Sơn Đầu Hỏa (Lửa trên núi)'
    when 1995
      'Sơn Đầu Hỏa (Lửa trên núi)'
    when 1996
      'Giản Hạ Thủy (Nước khe suối)'
    when 1997
      'Giản Hạ Thủy (Nước khe suối)'
    when 1998
      'Thành Đầu Thổ (Đất trên thành)'
    when 1999
      'Thành Đầu Thổ (Đất trên thành)'
    when 2000
      'Bạch Lạp Kim (Vàng sáp ong)'
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
end
