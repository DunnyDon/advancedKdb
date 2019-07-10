import csv,numpy
from datetime import datetime,date
from qpython import qconnection
from qpython.qcollection import qlist
from qpython.qtype import QException,QTIMESPAN_LIST,QSYMBOL_LIST,QFLOAT_LIST,QLONG_LIST,QDOUBLE_LIST
#Use qpython library to send messages Via IPC to kdb+ TP
time=[]
sym=numpy.array([])
price=numpy.array([])
size=numpy.array([])
exc=numpy.array([])
today = numpy.datetime64(datetime.now().replace(hour=0, minute=0, second=0, microsecond=0))
#Open file
with open('bid.csv','rt')as f:
  #skip first line as it has headers that we don't need to parse
  next(f)
  data = csv.reader(f)
  #go through each line in file and read in the date
  for row in data:
        newT=numpy.datetime64(datetime.combine(date.today(),datetime.strptime(row[0][2:-3],'%H:%M:%S.%f').time()))
        newT=numpy.timedelta64((numpy.datetime64(newT)-today), 'ns')

        time.append(newT)
        sym=numpy.append(sym,row[1])
        price=numpy.append(price,float(row[2]))
        size=numpy.append(size,int(float(row[3])))
        exc=numpy.append(exc,row[4])

#Convert each python dataType to their kdb+ equivalent
tme=qlist(time,qtype=QTIMESPAN_LIST)
sm=qlist(sym, qtype=QSYMBOL_LIST)
prc=qlist(price,qtype=QDOUBLE_LIST)
sze=qlist(size,qtype=QLONG_LIST)
ex=qlist(exc,qtype=QSYMBOL_LIST)
data = [tme,sm,prc,sze,ex]

#Open connection to tp
with qconnection.QConnection(host = 'localhost', port = 5000) as q:
        print(q)
        print('IPC version: %s. Is connected: %s' % (q.protocol_version, q.is_connected()))
        q.sendSync('.u.upd', numpy.string_('bid'), data)
        #call upd function on tp
