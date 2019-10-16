import random
import codecs
import string
from nltk.stem.porter import PorterStemmer
import gensim
from nltk import FreqDist
from itertools import chain

random.seed(123)


" ___*********** Part 1 starts here ***********___ "


f = codecs.open("pg3300.txt", "r", "utf-8")


def paragraphsplit(doc):
    """
    A function to split a document into paragraphs based on "\r\n", as well as remove puntuation and make the text lower
    case.
    :param doc: The document which is to be split.
    :return: The list of paragraphs.
    """
    paragraphlist = [""]
    for line in f.readlines():
        if line == '\r\n' and paragraphlist[-1] == "":
            pass
        elif line == '\r\n':
            paragraphlist.append("")
        else:
            paragraphlist[-1] = paragraphlist[-1] + " " + line.lower().translate({ord(i): None for i
                                                                                  in string.punctuation + "\r\n\t"})
    return paragraphlist


def liststrip(textlist: list):
    """
    Strips a list of paragraphs containing the word gutenberg.
    :param textlist: The list of paragraphs.
    :return: a list paragraphs which do not contain the word gutenberg.
    """
    newtextlist = []

    for line in textlist:
        if "gutenberg" not in line:
            newtextlist.append(line)
    return newtextlist


def tokenize(document: list):
    """
    Tokenizes the paragraphs in the given list.
    :param document: A list of documents.
    :return: a list of documents which are now tokenized.
    """
    tokenized_documents = []
    for paragraph in document:
        tokenized_documents.append(paragraph.split(" "))
    for doc in tokenized_documents:
        if doc[0] == "":
            doc.remove(doc[0])
    return tokenized_documents


def stemmer(doclist:list):
    """
    Stems the words in the documents.
    :param doclist: a list of documents which are lists of words.
    :return: a list of documents which are lists of stemmed words.
    """
    returndoclist = doclist
    stemobject = PorterStemmer()

    for index1, paragraph in enumerate(doclist):
        for index2, word in enumerate(paragraph):
            returndoclist[index1][index2] = stemobject.stem(word)
    return returndoclist





paragraphlist = paragraphsplit(f)
strippedparagraphs = liststrip(paragraphlist)
tokenized_documents = tokenize(strippedparagraphs)
stemmed_documents = stemmer(tokenized_documents)


dic = FreqDist(word for word in chain.from_iterable(stemmed_documents))


" ___*********** Part 2 starts here ***********___ "



dictionary = gensim.corpora.Dictionary(stemmed_documents)

# Gets common words
common = codecs.open("common.txt", 'r', 'UTF-8').readline().split(',')

# removes common words from documents
documents = [
     [token for token in doc if token not in common]
     for doc in stemmed_documents
]


def remove_stopwords(dictionary: gensim.corpora.Dictionary, stopwords):
    """
    Removes stopwords from the given dictionary
    :param dictionary: A Dictionary object
    :param stopwords: The stopwords which we want to remove
    :return: N/A
    """
    stop_ids = []
    for stopword in stopwords:
        if stopword in dictionary.token2id:
            stop_ids.append(dictionary.token2id[stopword])
    dictionary.filter_tokens(stop_ids)


remove_stopwords(dictionary, common)

corpus = [dictionary.doc2bow(doc) for doc in documents]

" ___*********** Part 3 starts here ***********___ "



# TF_IDF shit
tfidf_model = gensim.models.TfidfModel(corpus)
tfidf_corpus = tfidf_model[corpus]
tfidf_sim = gensim.similarities.MatrixSimilarity(tfidf_corpus)


# LSI shit
lsi_model = gensim.models.LsiModel(tfidf_corpus, id2word=dictionary,
num_topics=100)
lsi_corpus = lsi_model[tfidf_corpus]
lsi_sim = gensim.similarities.MatrixSimilarity(lsi_corpus)
# report 3.5
print(lsi_model.show_topics(3))


" ___*********** Part 4 starts here ***********___ "


def preprocessing(query : str):
    lower = query.lower()
    lowpunctrem = lower.translate({ord(i): None for i in string.punctuation + "\r\n\t"})
    tokenized = lowpunctrem.split(" ")
    stemobj = PorterStemmer()
    stemmed = [stemobj.stem(word) for word in tokenized]
    return stemmed



query  = "What is the function of money?"
BoW_query = dictionary.doc2bow(preprocessing(query))
# Report 4.2:
printlist = []
for i in tfidf_model[BoW_query]:
    printlist.append(tuple([dictionary.id2token[i[0]], round(i[1], 2)]))
print(printlist)



# TFIDF
query = dictionary.doc2bow(preprocessing(query))
tfidf_query = tfidf_model[query]

doc2similarity = enumerate(tfidf_sim[tfidf_query])
top3list = sorted(doc2similarity, key=lambda kv: -kv[1])[:3]
# Report 4.3:
for _tuple in top3list:
    print(str(_tuple[0]) + ":" + strippedparagraphs[_tuple[0]])

# LSI

lsi_query = lsi_model[query]

lsi_similarity = enumerate(lsi_sim[lsi_query])
sortedquery = sorted(lsi_query, key=lambda kv: -abs(kv[1]))[:3]
sorted_docsim = sorted(lsi_sim, key=lambda kv: -kv[1])[:3]
# Report 4.4:
for topic, val in sortedquery:
    print('[topic {}]'.format(topic))
    print(" " + lsi_model.show_topics()[topic][1])