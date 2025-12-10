from flask import Flask, request, jsonify 
import google.generativeai as genai 
import os 
from document_processor import process_document 



app = Flask(__name__) 

@app.route('/api/summarize',methods=['POST']) 
def summarize_document(): 
    genai.configure(API_KEY = os.getenv("API_KEY")) 
    model = genai.GenerativeModel("gemini-2.5-pro") 
    
    document_file = request.files.get('document') 
    
    if not document_file: 
        return jsonify({'error': 'No document file provided'}), 400 
        
    file_bytes = document_file.read() 
    file_extension = os.path.splitext(document_file.filename)[1] 
    
    try: 
        document_content = process_document(file_bytes, file_extension) 
    except ValueError as e: return jsonify({'error': str(e)}), 400 
    
    summary_length = request.form.get('summaryLength',0.5) 
    
    detail_level = request.form.get('detailLevel',2) 
    try: 
        summary_length = float(summary_length) 
        detail_level = int(detail_level) 
    except ValueError: 
        return jsonify({'error': 'Invalid summary length or detail level'}), 400 
        
    try: 
        prompt = f"Summarize the following text and keep the summary within {summary_length * 100}% of the original text length. Adjust the level of detail based on the provided detail level ({detail_level}):\n\n{document_content}" 
        response = model.generate_content(prompt) 
        summary = response.text 
        return jsonify({'summary': summary}) 
    except Exception as e: 
        return jsonify({'error': str(e)}), 500 

        
if __name__ == '__main__': 
    app.run(host='0.0.0.0', port=5000, debug=True)