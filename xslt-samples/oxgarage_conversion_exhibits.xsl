<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:wex="http://www.wwp.northeastern.edu/ns/exhibits"
    version="3.0">
    
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Exhibit Template Setup -->
    <xsl:template match="TEI">
        <xsl:processing-instruction name="oxygen">
            <xsl:text>RNGSchema="../schema/exhibits.rnc" type="compact"</xsl:text>
        </xsl:processing-instruction>
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:wex="http://www.wwp.northeastern.edu/ns/exhibits">
            
            <xsl:apply-templates/>
            
        </TEI>
    </xsl:template>
    
    <xsl:template match="teiHeader">
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title><xsl:comment>Insert title here</xsl:comment></title>
                    <author><xsl:comment>Author name (first last)</xsl:comment></author>
                </titleStmt>
                <publicationStmt>
                    <publisher>Northeastern University Women Writers Project</publisher>
                    <date when=""><xsl:comment>Exhibit publication date (Month, Year)</xsl:comment></date>
                </publicationStmt>
                <sourceDesc>
                    <p>None; born digital. This TEI P5 XML file was derived from submitted electronic source.</p>
                </sourceDesc>
            </fileDesc>
            <encodingDesc>
                <listPrefixDef>
                    <prefixDef ident="ea" matchPattern="(\i\c*)" replacementPattern="./editorial.xml#$1"/>
                    <prefixDef ident="ep" matchPattern="(\i\c*)" replacementPattern="./persons.xml#$1"/>
                    <prefixDef ident="el" matchPattern="(\i\c*)" replacementPattern="./places.xml#$1"/>
                    <prefixDef ident="ee" matchPattern="(\i\c*)" replacementPattern="./events.xml#$1"/>
                </listPrefixDef>
            </encodingDesc>
            <profileDesc>
                <wex:contextDesc>
                    <listEvent>
                        <xsl:comment>Insert entries for importnat events to be included in timeline. Use <gi>event</gi> element with <att>wex:ref</att> attribute for each entry. The attribute value should point to the events's corresponding entry in the events.xml file inside the distribution folder.</xsl:comment>
                        <event wex:ref="ee:evelina.ia"/>
                    </listEvent>
                    <listPerson>
                        <xsl:comment>Insert entries for people (exlcuding modern scholars and those referenced only in figure captions) significant to exhibit here. Use <gi>person</gi> element with <att>wex:ref</att> attribute for each entry. The attribute value should point to the person's corresponding entry in the persons.xml file inside the distribution folder.</xsl:comment>
                        <person wex:ref="ep:ehaywood.jzb"/>
                    </listPerson>
                </wex:contextDesc>
            </profileDesc>
        </teiHeader>
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:attribute name="ana"/>
            <figure rend="banner-top">
                <graphic url=""/>
                <ab type="caption"><xsl:comment>Banner caption here</xsl:comment>
                </ab>
                <ab type="credit"><xsl:comment>Banner credit line here</xsl:comment></ab>
            </figure>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
                <argument>
                    <p/>
                </argument>
                <div>
                    <xsl:apply-templates/>
                </div>
                <div xml:id="see-also">
                    <div>
                        <head>Primary Sources</head>
                        <listBibl/>
                    </div>
                    <div>
                        <head>Secondary Sources</head>
                        <listBibl/>
                    </div>
                    <div>
                        <head>Read More</head>
                        <listBibl/>
                    </div>
                </div>
        </xsl:copy>
    </xsl:template>
    
    
     
    <!-- Transformations To Contents of <text> -->
    <xsl:template match="p/@* | note/@* | table/@*"/>
    <xsl:template match="anchor | graphic"/>
    
    <xsl:template match="note/p">
            <xsl:apply-templates select="child::node()"/>
    </xsl:template>
    
    <!-- may need to uncomment following template for files initially converted from .rtf -->
    <!-- <xsl:template match="ref">
            <xsl:apply-templates select="child::node()"/>
    </xsl:template> -->
    
    <xsl:template match="ptr">
        <xsl:element name="ref">
            <xsl:apply-templates select="attribute::target | child::node()"/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="seg[@rend eq 'italic']">
        <xsl:element name="hi">
            <xsl:apply-templates select="attribute::rend | child::node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="seg">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="hi[@rend eq 'italic']">
        <xsl:copy>
            <xsl:apply-templates select="attribute::rend | child::node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="hi">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    

    
</xsl:stylesheet>