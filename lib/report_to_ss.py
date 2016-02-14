import sys
import json
import xlsxwriter

strlines = []
sections = {}

def process_question(q,responses,output,worksheet,row,col):
	try:
		response = responses[q['uuid']]
	except KeyError:
		return
	value = ""
	if 'value' in response:
		value = str(response['value'])
	if 'answer' in response:
		answer = "%s %s" % (response['answer'], value)
	else:
		answer =  "%s %s" % (q['answers'][response['answer_id']]['text'], value)
	output.append(answer)
	worksheet.write(row,col,answer)

def process_q_hdr(q, output, worksheet,col):
	try:
		q['answers'] = {r['uuid']: r for r in q['answers']}
				#print q['answers']
	except KeyError:
		pass
	output.append(q['text'])
	worksheet.write(1,col,q['text'])

def main():
	global strlines
	global sections
	f = open (sys.argv[1])
	strlines = f.readlines()
	lines = [json.loads(l) for l in strlines]
	#import pdb; pdb.set_trace()
	sections = lines[0]['sections']
	print lines
	response_sets = lines[1:]
	print response_sets
	name = "%s.xlsx" % lines[0]['title'].replace(" ", "-")
	workbook = xlsxwriter.Workbook(name)
	for response_set in response_sets:
		responses = response_set['responses']
		responses = {r['question_id']: r for r in responses}
		response_set['responses'] = responses
	for section in sections:
		name = "%s.csv" % section['title'].replace(" ", "-")
		o = open(name, 'w')
		worksheet = workbook.add_worksheet(section['title'])
		output = []
		qs = section['questions_and_groups']
		col = 0
		remove_me = []
		add_me = []
		for q in qs:
			if 'questions' in q:
					worksheet.merge_range(0,col,0,col+len(q['questions'])-1, q['text'])
					for q1 in q['questions']:
						process_q_hdr(q1, output, worksheet,col)
						col += 1
			else:
				process_q_hdr(q, output, worksheet,col)
				col += 1

		o.write(("\t".join(output)).encode('ascii', errors='backslashreplace'))
		o.write("\n")
	
		row = 2
		for response_set in response_sets:
			col = 0
			output = []
			responses = response_set['responses']
			print (response_set)
			for q in qs:
				if 'questions' in q:
					for q1 in q['questions']:
						process_question(q1,responses,output,worksheet,row,col)
						col += 1
				else:
					process_question(q,responses,output,worksheet,row,col)
					col += 1
			o.write("\t".join(output))
			o.write("\n")
			row += 1
		o.close()
	workbook.close()
	

if __name__ == "__main__":
    main()
				



