from flask import Flask, request, json
import pymssql

app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'hello world'

@app.route('/wuyan_suiji', methods=['POST'])
def wuyan_suiji():
    sql = """
    declare @m int = %d
    exec wuyan_suiji @m
    """
    length = int(json.loads(request.values.get("length")))
    conn = pymssql.connect(server='121.40.103.31',user='sa',password='Swufe@2021',database='project')
    cursor = conn.cursor()
    cursor.execute(sql, length)
    res_list = cursor.fetchall()
    result = res_list[0][0]
    cursor.close()
    conn.close()
    res = {'data':result}
    return json.dumps(res, ensure_ascii=False)

@app.route('/qiyan_suiji', methods=['POST'])
def qiyan_suiji():
    sql = """
    declare @m int = %d
    exec qiyan_suiji @m
    """
    length = int(json.loads(request.values.get("length")))
    conn = pymssql.connect(server='121.40.103.31',user='sa',password='Swufe@2021',database='project')
    cursor = conn.cursor()
    cursor.execute(sql, length)
    res_list = cursor.fetchall()
    result = res_list[0][0]
    cursor.close()
    conn.close()
    res = {'data':result}
    return json.dumps(res, ensure_ascii=False)

@app.route('/wuyan_cangtou', methods=['POST'])
def wuyan_cangtou():
    sql = """
        declare @head nvarchar(100) = %s
        exec wuyan_cangtou @head
        """
    head = str(json.loads(request.values.get("head")))
    conn = pymssql.connect(server='121.40.103.31',user='sa',password='Swufe@2021',database='project')
    cursor = conn.cursor()
    cursor.execute(sql, head)
    res_list = cursor.fetchall()
    result = res_list[0][0]
    cursor.close()
    conn.close()
    res = {'data':result}
    return json.dumps(res, ensure_ascii=False)

@app.route('/qiyan_cangtou', methods=['POST'])
def qiyan_cangtou():
    sql = """
        declare @head nvarchar(100) = %s
        exec qiyan_cangtou @head
        """
    head = str(json.loads(request.values.get("head")))
    conn = pymssql.connect(server='121.40.103.31',user='sa',password='Swufe@2021',database='project')
    cursor = conn.cursor()
    cursor.execute(sql, head)
    res_list = cursor.fetchall()
    result = res_list[0][0]
    cursor.close()
    conn.close()
    res = {'data':result}
    return json.dumps(res, ensure_ascii=False)

@app.route('/feihualing', methods=['POST'])
def feihualing():
    sql = """
        declare @ling nvarchar(10) = %s
        exec feihualing @ling
        """
    ling = str(json.loads(request.values.get("ling")))
    conn = pymssql.connect(server='121.40.103.31',user='sa',password='Swufe@2021',database='project')
    cursor = conn.cursor()
    cursor.execute(sql, ling)
    res_list = cursor.fetchall()
    cursor.close()
    conn.close()
    if res_list:
        res = {
            'title':res_list[0][0],
            'dynasty':res_list[0][1],
            'author':res_list[0][2],
            'contents':res_list[0][3],
            'juzi':res_list[0][4],
            'msg':'Correct'
        }
    else:
        res = {'msg':'Error'}
    return json.dumps(res,ensure_ascii=False)

if __name__=='__main__':
    app.run(debug = True)