import os
import re

# define function to process text
def process_text(text):
    # remove []s + contents.
    text = re.sub(r'\\s*(.*?)\s*', r'', text)
    text = re.sub(r'\[.*?\]', '', text)
    # remove XML elements + attributes, keep words.
    text = re.sub(r'<[^>]+>(.*?)<\/[^>]+>', r'\1', text)
    # remove / and convert & -> and
    text = text.replace('/', '').replace('&', 'and')
    # remove blank lines, norm whitespace.
    text = '\n'.join(line.strip() for line in text.splitlines() if line.strip())
    text = ' '.join(text.split())
    return text

# function to process a single file.
def process_file(file_path):
	#open file
    with open(file_path, 'rb') as file:
        content = file.read().decode('utf-8', 'ignore')
	#process file
    processed_content = process_text(content)
	#overwrite file
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(processed_content)

# working dir
directory_path = '/Users/jakemurel/Desktop/EMEMT_Corpus_NORM'
# iterate through .txt files in working dir
for filename in os.listdir(directory_path):
    if filename.endswith('.txt'):
        file_path = os.path.join(directory_path, filename)
        process_file(file_path)
# confirm finished
print("Text files processed successfully.")