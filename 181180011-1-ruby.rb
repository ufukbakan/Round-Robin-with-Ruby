# Ufuk Bakan - Gazi Univeristy - 181180011 - 2020
class Islem
  @@simdikiZaman = 0
  attr_accessor :islemAdi, :kalanIslemZamani, :beklemeZamani
  attr_reader :tepkiZamani
  def initialize(kalanIslemZamani, islemAdi)
    @kalanIslemZamani = kalanIslemZamani
    @islemAdi = islemAdi
    @tepkiZamani = -1
    @beklemeZamani = 0
  end

  def self.getTime
    return @@simdikiZaman
  end

  def isle(quantum)
    if(@tepkiZamani == -1) then
      @tepkiZamani = @@simdikiZaman
    end

    if(@kalanIslemZamani > quantum) then
      @kalanIslemZamani -= quantum
      @@simdikiZaman += quantum
    else
      @@simdikiZaman += @kalanIslemZamani
      @kalanIslemZamani = 0
    end
  end
end

def islemYap(sira, quantum)
  contextSwitch = 0
  baslangic = Islem.getTime
  i = 0
  while i < sira.length - 1 do
    print sira[i].islemAdi + "-" + sira[i].kalanIslemZamani.to_s + "\t\t"
    i+=1
  end
  #for islem in sira do
  #  print islem.islemAdi + "-" + #islem.kalanIslemZamani.to_s + "\t\t"
  #end
  print sira[i].islemAdi + "-" + sira[i].kalanIslemZamani.to_s + " <== sıranın başı\n"
  
  islemeAlinan = sira.pop
  islemeAlinan.isle(quantum)

  deltaSure = Islem.getTime - baslangic

  for islem in sira do
    islem.beklemeZamani += deltaSure
  end

  if (islemeAlinan.kalanIslemZamani > 0) then
    #İşlem tamamlanmadıysa tekrar sıraya sokulur
    sira.unshift(islemeAlinan)
  end
  if sira.length > 0 && sira[-1] != islemeAlinan then
    contextSwitch = 1
  end
  
  puts islemeAlinan.islemAdi + " için birim işlem yapıldı"
  if contextSwitch == 1 then
    puts "Context switch + 1"
  end
  puts "Toplam geçen zaman : " + Islem.getTime.to_s
  #İşlem sonrası bir context switch oluşuyorsa 1 döndürür
  return contextSwitch
end



#İşlemler için bir sıra oluştur
sira = []
quantum = 5.0

P1 = Islem.new(10.0,"P1")
P2 = Islem.new(3.0,"P2")
P3 = Islem.new(20.0,"P3")

#İşlemleri sıraya ekle :
sira.unshift(P1)
sira.unshift(P2)
sira.unshift(P3)

toplamContextSwitch = 0
puts "Quantum değeri (Time Quantum / TQ): " + quantum.to_s
while sira.length > 0 do
toplamContextSwitch += islemYap(sira, quantum)
end

for islem in sira do
    print islem.islemAdi
    print "-"
    print islem.kalanIslemZamani
    print "\n"
end
puts "Geçen zaman : " + Islem.getTime.to_s
puts "Toplam Context Switch : " + toplamContextSwitch.to_s
puts "P1'e Tepki süresi (response time) : " + P1.tepkiZamani.to_s
puts "P2'ye Tepki süresi (response time) : " + P2.tepkiZamani.to_s
puts "P3'e Tepki süresi (response time) : " + P3.tepkiZamani.to_s
puts "Ortalama tepki süresi (Average response time) : " + ((P1.tepkiZamani + P2. tepkiZamani + P3.tepkiZamani)/3.0).to_s
puts "P1'in bekleme süresi (wait time) : " + P1.beklemeZamani.to_s
puts "P2'nin bekleme süresi (wait time) : " + P2.beklemeZamani.to_s
puts "P3'ün bekleme süresi (wait time) : " + P3.beklemeZamani.to_s
puts "Ortalama bekleme süresi (Average wait time) : " + ((P1.beklemeZamani + P2.beklemeZamani + P3.beklemeZamani)/3.0).to_s