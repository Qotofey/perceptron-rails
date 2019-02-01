module PorterStemmer

  def stem(word)
    word = word.downcase.gsub('ё', 'е')
    m = RVRE.match(word)
    if m && m.captures.count > 0
      pre = m.captures[0]
      rv = m.captures[1]
      temp = rv.sub(PERFECTIVEGROUND, '')
      if temp == rv
        rv = rv.sub(REFLEXIVE, '')
        temp = rv.sub(ADJECTIVE, '')
        if temp != rv
          rv = temp
          rv = rv.sub(PARTICIPLE, '')
        else
          temp = rv.sub(VERB, '')
          if temp == rv
            rv = rv.sub(NOUN, '')
          else
            rv = temp
          end
        end
      else
        rv = temp
      end
      rv = rv.sub(I, '')
      if DERIVATIONAL.match?(rv)
        rv = rv.sub(DER, '')
      end
      temp = rv.sub(P, '')
      if temp == rv
        rv = rv.sub(SUPERLATIVE, '')
        rv = rv.sub(NN, 'н')
      else
        rv = temp
      end
      word = pre + rv
    end
    word
  end

private

  PERFECTIVEGROUND = /((ив|ивши|ившись|ыв|ывши|ывшись)|((?<=[ая])(в|вши|вшись)))$/
  REFLEXIVE = /(с[яь])$/
  ADJECTIVE = /(ее|ие|ые|ое|ими|ыми|ей|ий|ый|ой|ем|им|ым|ом|его|ого|ему|ому|их|ых|ую|юю|ая|яя|ою|ею)$/
  PARTICIPLE = /((ивш|ывш|ующ)|((?<=[ая])(ем|нн|вш|ющ|щ)))$/
  VERB = /((ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю)|((?<=[ая])(ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно)))$/
  NOUN = /(а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|и|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я)$/
  RVRE = /^(.*?[аеиоуыэюя])(.*)$/
  DERIVATIONAL = /.*[^аеиоуыэюя]+[аеиоуыэюя].*ость?$/
  DER = /ость?$/
  SUPERLATIVE = /(ейше|ейш)$/
  I = /и$/
  P = /ь$/
  NN = /нн$/

end