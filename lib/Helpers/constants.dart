library constants;

String lorem =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

String loremShort =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ";

const FINISHED_ON_BOARDING = 'finishedOnBoarding';
const COLOR_PRIMARY = 0xFF000E57;
const COLOR_SECONDARY = 0xffEDC97A;
const COLOR_BACKGROUND = 0xffFFFDFA;
const COLOR_TITLE = 0xff292e45;
const COLOR_SUBTITLE = 0xff666d8c;

const APP_TITLE = 'FliQCard';
const APP_SUBTITLE = 'Go Paperless. Go Green.';
const APP_LOGO_PATAH = 'assets/logo.png';
const ASSET_PATAH = 'assets/';
const API_KEY = "";
const currencySymbl = "\$";

const apiUrl = "https://fliqcard.com/digitalcard/dashboard/mobileapi";
const termsandconditions = "https://fliqcard.com/digitalcard/terms.php";

const register = apiUrl + "/register.php";
const login = apiUrl + "/login.php";
const forgot = apiUrl + "/forgot.php";
const activateplan = apiUrl + "/activateplan.php";

const deletebanner = apiUrl + "/deletebanner.php";
const deletelogo = apiUrl + "/deleteLogo.php";
const deleteprofile = apiUrl + "/deleteProfile.php";

const appversion = apiUrl + "/appversion.php";
const getdata = apiUrl + "/getdata2.php";
const updateContact = apiUrl + "/updateContact.php";
const deletecontact = apiUrl + "/deleteContact.php";
const updatestaff = apiUrl + "/updatestaff.php";
const deletestaff = apiUrl + "/deletestaff.php";
const changepassword = apiUrl + "/changepassword.php";
const addeditcard = apiUrl + "/vcard.php";
const theme_toggle = apiUrl + "/theme_toggle.php";
const updateLocation = apiUrl + "/updatelocation.php";
const updateattendance = apiUrl + "/updateattendance.php";

const getsharedcards = apiUrl + "/getsharedcards.php";
const getdistinctcards = apiUrl + "/getdistinctcards.php";
const acceptcard = apiUrl + "/acceptcard.php";

const sendcard = apiUrl + "/sendcard.php";
const setBanner = apiUrl + "/setBanner.php";

const getfollowup = apiUrl + "/getfollowup.php";
const getcomments = apiUrl + "/getcomments.php";
const addFollowup = apiUrl + "/addFollowup.php";

const cancelFollowup = apiUrl + "/cancelFollowup.php";
const completeFollowup = apiUrl + "/completeFollowup.php";
const rescheduleFollowup = apiUrl + "/rescheduleFollowup.php";

const getevents = apiUrl + "/getevents.php";
const deleteEvent = apiUrl + "/deleteEvent.php";
const updateFcmToken = apiUrl + "/updateFcmToken.php";
const events_invites = apiUrl + "/events_invites.php";


List<String> countriesList = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegowina",
  "Botswana",
  "Bouvet Island",
  "Brazil",
  "British Indian Ocean Territory",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Cape Verde",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos (Keeling) Islands",
  "Colombia",
  "Comoros",
  "Congo",
  "Congo, the Democratic Republic of the",
  "Cook Islands",
  "Costa Rica",
  "Cote d'Ivoire",
  "Croatia (Hrvatska)",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "East Timor",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Ethiopia",
  "Falkland Islands (Malvinas)",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "France Metropolitan",
  "French Guiana",
  "French Polynesia",
  "French Southern Territories",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Heard and Mc Donald Islands",
  "Holy See (Vatican City State)",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran (Islamic Republic of)",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, Democratic People's Republic of",
  "Korea, Republic of",
  "Kuwait",
  "Kyrgyzstan",
  "Lao, People's Democratic Republic",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libyan Arab Jamahiriya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macau",
  "Macedonia, The Former Yugoslav Republic of",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia, Federated States of",
  "Moldova, Republic of",
  "Monaco",
  "Mongolia",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "Netherlands Antilles",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Niue",
  "Norfolk Island",
  "Northern Mariana Islands",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Reunion",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia (Slovak Republic)",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia and the South Sandwich Islands",
  "Spain",
  "Sri Lanka",
  "St. Helena",
  "St. Pierre and Miquelon",
  "Sudan",
  "Suriname",
  "Svalbard and Jan Mayen Islands",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syrian Arab Republic",
  "Taiwan, Province of China",
  "Tajikistan",
  "Tanzania, United Republic of",
  "Thailand",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks and Caicos Islands",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "United States Minor Outlying Islands",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela",
  "Vietnam",
  "Virgin Islands (British)",
  "Virgin Islands (U.S.)",
  "Wallis and Futuna Islands",
  "Western Sahara",
  "Yemen",
  "Yugoslavia",
  "Zambia",
  "Zimbabwe"
];
