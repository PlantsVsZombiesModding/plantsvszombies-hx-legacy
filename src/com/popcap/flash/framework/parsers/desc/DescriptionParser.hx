package com.popcap.flash.framework.parsers.desc
;
    class DescriptionParser
   {
       
      
      public function new()
      {
         //super();
      }
      
      public function parse(descriptor:String) : Array<ASAny>
      {
         var crFilter= new compat.RegExp("\\r", "g");
         var commentFilter= new compat.RegExp("^ ?#.*$", "gm");
         var nlFilter= new compat.RegExp("\\n", "g");
         var whitespaceFilter= new compat.RegExp("\\t|[ ]+", "g");
         descriptor = crFilter.replace(descriptor,"");
         descriptor = whitespaceFilter.replace(descriptor," ");
         descriptor = commentFilter.replace(descriptor,"");
         descriptor = nlFilter.replace(descriptor,"");
         var results= this.parseCommands(descriptor);
         if(results == null)
         {
            return null;
         }
         return results;
      }
      
      function parseToList(state:ParseState, list:ListDataElement, expectListEnd:Bool) : Bool
      {
         var addSingleChar= false;
         var aChar:String = null;
         var isSeparator= false;
         var childList:ListDataElement = null;
         var inSingleQuotes:ASAny = false;
         var inDoubleQuotes:ASAny = false;
         var isEscaped= false;
         var wantTerminate= false;
         var keyElement:SingleDataElement = null;
         var currentElement:SingleDataElement = null;
         var len:Float = state.line.length;
         while(state.linePosition < len)
         {
            addSingleChar = false;
            aChar = state.readChar();
            isSeparator = aChar == " " || aChar == ",";
            if(isEscaped)
            {
               addSingleChar = true;
            }
            else
            {
               if(aChar == "\'" && !inDoubleQuotes)
               {
                  inSingleQuotes = !inSingleQuotes;
                  continue;
               }
               if(aChar == "\"" && !inSingleQuotes)
               {
                  inDoubleQuotes = !inDoubleQuotes;
                  continue;
               }
               if(aChar == "\\")
               {
                  isEscaped = true;
               }
               else if(!inSingleQuotes && !inDoubleQuotes)
               {
                  if(aChar == ";")
                  {
                     return true;
                  }
                  if(aChar == ")")
                  {
                     if(expectListEnd)
                     {
                        return true;
                     }
                     throw new Error("Unexpected List End.");
                  }
                  if(aChar == "(")
                  {
                     if(wantTerminate)
                     {
                        currentElement = null;
                        wantTerminate = false;
                     }
                     if(currentElement != null)
                     {
                        throw new Error("Unexpected List Start.");
                     }
                     childList = new ListDataElement();
                     if(!this.parseToList(state,childList,true))
                     {
                        return false;
                     }
                     if(keyElement != null)
                     {
                        keyElement.mValue = childList;
                        keyElement = null;
                     }
                     else
                     {
                        list.mElements.push(childList);
                     }
                  }
                  else if(aChar == "=")
                  {
                     keyElement = currentElement;
                     wantTerminate = true;
                  }
                  else if(isSeparator)
                  {
                     if(currentElement != null && currentElement.mString.length > 0)
                     {
                        wantTerminate = true;
                     }
                  }
                  else
                  {
                     if(wantTerminate)
                     {
                        currentElement = null;
                        wantTerminate = false;
                     }
                     addSingleChar = true;
                  }
               }
               else
               {
                  if(wantTerminate)
                  {
                     currentElement = null;
                     wantTerminate = false;
                  }
                  addSingleChar = true;
               }
            }
            if(addSingleChar)
            {
               if(currentElement == null)
               {
                  currentElement = new SingleDataElement();
                  if(keyElement != null)
                  {
                     keyElement.mValue = currentElement;
                     keyElement = null;
                  }
                  else
                  {
                     list.mElements.push(currentElement);
                  }
               }
               if(isEscaped)
               {
                  currentElement.mString += "\\";
                  isEscaped = false;
               }
               currentElement.mString += aChar;
            }
         }
         if(inSingleQuotes)
         {
            throw new Error("Unterminated Single Quotes.");
         }
         if(inDoubleQuotes)
         {
            throw new Error("Unterminated Double Quotes.");
         }
         if(expectListEnd)
         {
            throw new Error("Unterminated List.");
         }
         return true;
      }
      
      function parseCommands(line:String) : Array<ASAny>
      {
         var command:ListDataElement = null;
         var elem:DataElement = null;
         var state= new ParseState();
         state.line = line;
         state.linePosition = 0;
         var commands= new Array<ASAny>();
         while(!state.isEOF())
         {
            command = new ListDataElement();
            if(!this.parseToList(state,command,false))
            {
               return null;
            }
            commands.push(command);
         }
         var numElements= commands.length;
         var i= numElements - 1;while(i > -1)
         {
            elem = commands[i];
i += -1;
         }
         return commands;
      }
   }

