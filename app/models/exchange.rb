class Exchange < ApplicationRecord
  after_create :company_serial_no_checker

  def company_serial_no_checker(serial)

    # 共八位，全部為數字型態
    at_least_8_digits =  /^\d{8}$/
    return false unless at_least_8_digits.match(serial)
  
    # 各數字分別乘以 1,2,1,2,1,2,4,1
    # 例：統一編號為 53212539
    #
    # Step1 將統編每位數乘以一個固定數字固定值
    #   5   3   2   1   2   5   3   9
    # x 1   2   1   2   1   2   4   1
    # ================================
    #   5   6   2   2   2  10  12   9
    #
  
    result = []
    serial_array = serial.split('')
    num_array = [1, 2, 1, 2, 1, 2, 4, 1]
    serial_array.zip(num_array) { |a, b| result << a.to_i * b }
  
    # Step2 將所得值取出十位數及個位數
    # 十位數 個位數
    #   0      5
    #   0      6
    #   0      2
    #   0      2
    #   0      2
    #   1      0
    #   1      2
    #   0      9
    #
    # 並將十位數與個位數全部結果值加總
    #
  
    sum = 0
    result.each { |elm| 
      sum += elm.divmod(10).inject { |s, i| s + i }
    }
  
    # Step3 判斷結果
    # 第一種:加總值取10的餘數為0
    # 第二種:加總值取9的餘數等於9而且統編的第6碼為7
  
    return true if (sum % 10 == 0) or (sum % 9 == 9 and serial[5] == 7)
  
  end  
end
