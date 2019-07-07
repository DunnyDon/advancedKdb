import csv,numpy
from datetime import datetime,date
from qpython import qconnection
from qpython.qcollection import qlist
from qpython.qtype import QException,QTIMESPAN_LIST,QSYMBOL_LIST,QFLOAT_LIST,QLONG_LIST
time=[]
sym=numpy.array([])
price=numpy.array([])
size=numpy.array([])
exc=numpy.array([])
today = numpy.datetime64(datetime.now().replace(hour=0, minute=0, second=0, microsecond=0))
with open('bid.csv','rt')as f:
  next(f)
  data = csv.reader(f)
  for row in data:
        newT=numpy.datetime64(datetime.combine(date.today(),datetime.strptime(row[0][2:-3],'%H:%M:%S.%f').time()))
        newT=numpy.timedelta64((numpy.datetime64(newT)-today), 'ns')

        time.append(newT)
        sym=numpy.append(sym,row[1])
        price=numpy.append(price,float(row[2]))
        size=numpy.append(size,int(float(row[3])))
        exc=numpy.append(exc,row[4])


tme=qlist(time,qtype=QTIMESPAN_LIST)
sm=qlist(sym, qtype=QSYMBOL_LIST)
prc=qlist(price,qtype=QFLOAT_LIST)
sze=qlist(size,qtype=QLONG_LIST)
ex=qlist(exc,qtype=QSYMBOL_LIST)
data = [tme,sm,prc,sze,ex]


with qconnection.QConnection(host = 'localhost', port = 5000) as q:
        print(q)
        print('IPC version: %s. Is connected: %s' % (q.protocol_version, q.is_connected()))
        q.sendSync('.u.upd', numpy.string_('bid'), data)
