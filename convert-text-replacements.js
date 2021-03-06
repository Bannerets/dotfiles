#!/usr/bin/env node

const path = require('path')
const fs = require('fs')

const inputFile = path.join(__dirname, 'text-replacements.txt')
const outputFile = path.join(__dirname, 'text-replacements.plist')

let count = 0

function printStatus (replacement) {
  const num = ('0000' + (count + 1)).slice(-5)
  console.log(` ${num}  '${replacement.from}' -> '${replacement.to}'`)
}

function parseLine (line) {
  if (line[0] === '#') return
  const [from, to] = line.split('->')
  if (!to)
    return console.error(`Invalid line: "${line}"`)
  const replacement = { from: from.trim(), to: to.trim() }
  printStatus(replacement)
  count++
  return replacement
}

function parse (input) {
  return input.split('\n')
    .filter(s => s.length > 0)
    .map(parseLine)
    .filter(Boolean)
}

function xmlEscape (str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
}

function generateReplacement (replacement) {
  return (
`  <dict>
    <key>on</key>
    <integer>1</integer>
    <key>replace</key>
    <string>${xmlEscape(replacement.from)}</string>
    <key>with</key>
    <string>${xmlEscape(replacement.to)}</string>
  </dict>`
  )
}

function generate (replacements) {
  const head = `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<!-- AUTOGENERATED -->`
  return [
    head,
    '\n<array>\n',
    replacements.map(generateReplacement).join('\n'),
    '\n</array>\n',
    '</plist>\n'
  ].join('')
}

const contents = fs.readFileSync(inputFile).toString()

const output = generate(parse(contents))

if (output)
  fs.writeFileSync(outputFile, output)
