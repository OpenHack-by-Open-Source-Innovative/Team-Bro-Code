from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
 

sent_obj = SentimentIntensityAnalyzer()


def sentiment_scores(sentence):
 
 
    sentiment_dict = sent_obj.polarity_scores(sentence)
    
    sentiment_dict['neg'] = str(sentiment_dict['neg']*100)
    sentiment_dict['neu'] = str(sentiment_dict['neu']*100)
    sentiment_dict['pos'] = str(sentiment_dict['pos']*100)
 

    if sentiment_dict['compound'] >= 0.05 :
        sent = "Positive"
 
    elif sentiment_dict['compound'] <= -0.05 :
        sent = "Negative"
 
    else :
        sent = "Neutral"

    return sent, [sentiment_dict['neg'], sentiment_dict['neu'], sentiment_dict['pos']]



def sentiment_pipeline(text):
    if type(text) is str:
        return [sentiment_scores(text)]
    else:
        result = [sentiment_scores(x) for x in text]
        return result
