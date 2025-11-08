#--Importing the module required for gui application--------

from tkinter import *
from tkinter import messagebox
import tkinter as tk

#--Gui Interaction ----------

window = tk.Tk()
window.title("CALCULATOR")
window.geometry("300x300")

#--Adding the input---------------------

entry = tk.Entry(
    window,
    font=("Arial", 20),      
    width=200,                 
    borderwidth=2,
    relief="solid",           
    justify="right")           
    
entry.pack(pady=20, ipady=100 , ipadx=500 ,padx=10) 

#-- Button Click Function --
def button_click(value):
    entry.insert(END, str(value))

def clear_entry():
    entry.delete(0, END)

def calculate_result():
    try:
        result = eval(entry.get())
        entry.delete(0, END)
        entry.insert(0, str(result))
    except:
        messagebox.showerror("Error", "Invalid Expression")

#-- Buttons Layout --
button_frame = tk.Frame(window)
button_frame.pack()

buttons = [
    ['7', '8', '9', '+'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '*'],
    ['C', '0', '=', '/']
]

for r, row in enumerate(buttons):
    for c, char in enumerate(row):
        if char == 'C':
            action = clear_entry
        elif char == '=':
            action = calculate_result
        else:
            action = lambda x=char: button_click(x)
        
        btn = tk.Button(
            button_frame,
            text=char,
            width=5,
            height=2,
            font=("Arial", 18),
            command=action
        )
        btn.grid(row=r, column=c, padx=10, pady=10)




window.mainloop()
