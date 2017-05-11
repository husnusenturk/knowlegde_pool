# regex

You can control your regular expressions from this site: https://regex101.com/  
Most of examples are quoted from https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149  

## Special Characters for regular expression:

Twelve characters have special meanings in regular expressions. These special characters are often called "metacharacters". Most of them are errors when used alone. If you want to use any of these characters as a literal in a regex, you need to escape them with a backslash.

<ol>
<li> the backslash \ </li> 
<li> the caret ^ </li>
<li> the dollar sign $ </li>
<li> the period or dot . </li>
<li> the vertical bar or pipe symbol | </li>
<li> the question mark ? </li>
<li> the asterisk or star * </li>
<li> the plus sign + </li>
<li> the opening parenthesis ( </li>
<li> the closing parenthesis ) </li>
<li> the opening square bracket [ </li>
<li> the opening curly brace { </li>

## Shorthand Characters
* \d is short for [0-9].
* \w is short for [A-Za-z0-9_].
* \s is short for a space, a tab, a line break, or a form feed. Most flavors also include the vertical tab,  
Which characters this shorthands actually includes, depends on the regex flawor.

## Negated Shorthand Characters
\D is the same as [^\d], \W is short for [^\w] and \S is the equivalent of [^\s].  

## Star (*) versus plus (+)
* 0 or more of the preceding expression  
+ 1 or more of the preceding expression  

For example
`^[a-z]*$` this expression is match with no character or all letters.
`^[a-z]+$` this expression is match with at least one letter. 
 
## Group Definition
Expressions in pharantesis shows groups in regular expression. 

For example in this regular expression; `^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$`
Group 1: `(https?:\/\/)`
Group 2: `([\da-z\.-]+)`
Group 3: `([a-z\.]{2,6})`
Group 4: `([\/\w \.-]*)`

## Regex Examples

You could use this in gr[ae]y to match either gray or grey.  
You can use a hyphen inside a character class to specify a range of characters. [0-9] matches a single digit between 0 and 9.  
You can use more than one range. [0-9a-fA-F] matches a single hexadecimal digit, case insensitively.  
You can combine ranges and single characters. [0-9a-fxA-FX] matches a hexadecimal digit or the letter x case insensitively.  
Typing a caret after the opening square bracket negates the character class. The result is that the character class matches any character that is not in the character class. q[^x] matches qu in question. It does not match Iraq since there is no character after the q for the negated character class to match.

### Matching a Username  
**Pattern:**  
```regex
^[a-z0-9_-]{3,16}$  
```
**`^` :** beginning of the string  
**`[a-z0-9_-]`:** followed by any lowercase letter (a-z), number (0-9), an underscore, or a hyphen. {3,16} : makes sure that are at least 3 of those characters, but no more than 16.   
**`$` :** end of the string  
**String that matches:** my-us3r_n4m3

### Matching a Password:  
**Pattern:**  
```regex
^[a-z0-9_-]{6,18}$  
```
Matching a password is very similar to matching a username. The only difference is that instead of 3 to 16 letters, numbers, underscores, or hyphens, we want 6 to 18 of them ({6,18}).  
**String that matches:** myp4ssw0rd  

### Matching a Hex Value  
**Pattern:**  
```regex
^#?([a-f0-9]{6}|[a-f0-9]{3})$  
```
**`^` :** beginning of the string 
**`\#?` :** a number sign "#" is optional because it is followed a question mark. Question mark tells the parser that the preceding character — in this case a number sign — is optional.  
**`([a-f0-9]{6}|[a-f0-9]{3})` :** Inside the first group (first group of parentheses), we can have two different situations. The first is any lowercase letter between a and f or a number six times. The vertical bar tells us that we can also have three lowercase letters between a and f or numbers instead.  
**`$` :** end of the string   
**String that matches:** #a3c113  

### Matching an Email  
**Pattern:** 
```regex
^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$    
```
**`^` :** beginning of the string  
**`([a-z0-9_\.-]+)` :** Inside the first group, we match one or more lowercase letters, numbers, underscores, dots, or hyphens. Dot is escaped because a non-escaped dot means any character.  
**`@` :** There must be an at sign.
**`([\da-z\.-]+)` :** the domain name which must be: one or more lowercase letters, numbers, underscores, dots, or hyphens.  
**`\.` :**  Then another (escaped) dot  
**`([a-z\.]{2,6})` :**  extension being two to six letters or dots.  2 to 6 because of the country specific TLD's (.ny.us or .co.uk).  
**`$` :** end of the string   
**String that matches:** john@doe.com  	

### Matching a URL   
**Pattern:** 
```regex
^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$   
```
**`^` :** beginning of the string  
**`(https?:\/\/)?` :** The first capturing group is all optional because of the question mark which is end of group definition. It allows the URL to begin with "http://", "https://", or neither of them. Question mark after the s to allow URL's that have http or https.  
**`([\da-z\.-]+)` :** Domain name: one or more numbers, letters, dots, or hypens  
**`\.` :** dot  
**`([a-z\.]{2,6})` :** two to six letters or dots.  
**`([\/\w \.-]*)*` :** section is the optional files and directories. Inside the group, we want to match any number of forward slashes, letters, numbers, underscores, spaces, dots, or hyphens. Then we say that this group can be matched as many times as we want. Pretty much this allows multiple directories to be matched along with a file at the end. I have used the star instead of the question mark because the star says zero or more, not zero or one. If a question mark was to be used there, only one file/directory would be able to be matched.  
**`\/?` :** A trailing slash is matched, but it can be optional.  
**`$` :** end of the string  
**String that matches:** http://net.tutsplus.com/about  
**String that doesn't match:** http://google.com/some/file!.html (contains an exclamation point)  


