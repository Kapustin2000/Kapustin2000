Как интегрировать Google ADK с кастомным интерфейсом: пошаговое руководство с примерами / Habr

Level of difficulty: Medium
Reading time: 9 min
Reach and readers: 7.8K

Tags: google adk, ai agent, ai agent tutorial, ai agents, google agent engine, python
Hubs: Cloud services, Google API, Google Cloud Platform, Artificial Intelligence, Python

Всем здравствуйте!

Меня зовут Mykhailo Kapustin, я разработчик с 10-летним опытом работы, соучредитель и технический директор в научно-исследовательском проекте Advanced Scientific Research Projects.

Недавно передо мной встала задача — создать кастомного интерактивного агента с кастомным UI, который можно было бы встроить в существующую инфраструктуру проекта. Я начал ресерч, провел встречи с другими инженерами, включая Grigory Nosyrev (Senior Software Engineer, Workato), и понял: материалов по интеграции Google Agent Development Kit (ADK) в реальные интерфейсы почти нет.

Что такое Google ADK: краткое описание возможностей

Google Agent Development Kit (ADK) — это open-source-инструментарий от Google, представленный 9 апреля 2025 года. Он предназначен для создания LLM-агентов, способных вести диалог, вызывать внешние функции, работать с внутренним состоянием, подключать документы и выстраивать reasoning-процессы.

Простого агента на Google ADK создать несложно

Вот пример минимального агента, используя официальный пакет adk-python:

from google.adk.agents import Agent
from google.adk.tools import google_search

root_agent = Agent(
   name="search_assistant",
   model="gemini-2.0-flash",
   instruction="You are a helpful assistant. Answer user questions using Google Search when needed.",
   description="An assistant that can search the web.",
   tools=[google_search]
)

Запустить агента можно командой: adk web

Архитектура агента Google ADK: сессии, reasoning, state

Когда вы отправляете первое сообщение через поле "Type a message…" в веб-интерфейсе adk web, Google ADK автоматически создаёт уникальную сессию для текущего диалога.

Внутри каждой сессии агент ведёт собственное внутреннее состояние, в которое входит: история сообщений; размышления и промежуточные шаги reasoning-процесса; список вызванных функций и событий; артефакты.

Подключение кастомного UI к Google ADK через FastAPI

Google ADK разворачивает полноценный FastAPI-сервер, и adk web использует его напрямую. Чтобы запустить ADK API, достаточно команды:

adk api_server

После этого локально запускается FastAPI-интерфейс на порту 8000 с полной OpenAPI-документацией, включая маршруты: POST /run, GET /run_sse, POST /sessions, POST /evals, GET /artifacts.

Как задеплоить агента: Vertex AI, Cloud Run или Docker

Google предлагает три официальных способа развёртывания:
1. Vertex AI Agent Engine — полностью управляемое решение от Google Cloud.
2. Cloud Run — простой способ запустить контейнер в облаке.
3. Custom Infrastructure — самостоятельное управление через Docker, GKE или on-premise.

После деплоя: знакомство с Agent Engine API

Когда вы задеплоили агента через Vertex AI Agent Engine, вы начинаете работать с отдельным API — Agent Engine API, который Google разработал поверх ADK.

Методы работы с сессиями: create_session, get_session, list_sessions, delete_session.
Методы взаимодействия с агентом: stream_query, async_stream_query, streaming_agent_run_with_events.

Интеграция с продакшен-системой: как подключить модель к вашему продукту

В своём проекте я выбрал прокси-бэкенд, который: авторизует пользователей, фильтрует/обогащает ответы, логирует данные, и запрашивает состояние сессии у модели.

Управление состоянием сессии: как обновлять state во время общения

ADK предоставляет механизм коллбэков — функций, которые вызываются автоматически после генерации ответа или выполнения инструмента.

Вывод

Интеграция с Google ADK и Vertex AI Agent Engine — это не просто способ подключить LLM к продукту. Это возможность построить гибкую и масштабируемую архитектуру, в которой модель становится полноценным участником диалога.

© Фото автора данной статьи — Mykhailo Mykhailovich Kapustin.
